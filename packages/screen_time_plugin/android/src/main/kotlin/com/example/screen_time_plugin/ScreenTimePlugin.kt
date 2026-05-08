package com.example.screen_time_plugin

import android.app.AppOpsManager
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.json.JSONArray
import org.json.JSONObject
import java.time.Instant
import java.time.ZoneId
import java.util.UUID

class ScreenTimePlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "screen_time")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "hasPermission" -> result.success(hasUsagePermission())
            "requestPermission" -> {
                requestUsagePermission()
                result.success(null)
            }
            "getScreenTime" -> {
                if (!hasUsagePermission()) {
                    result.error("PERMISSION_DENIED", "Usage Access not granted", null)
                    return
                }
                val startTime       = call.argument<Long>("start_time")!!
                val endTime         = call.argument<Long>("end_time")!!
                val intervalSeconds = call.argument<Int>("interval_seconds")!!

                try {
                    val json = buildScreenTimeReport(startTime, endTime, intervalSeconds)
                    result.success(json.toString())
                } catch (e: Exception) {
                    result.error("ERROR", e.message, null)
                }
            }
            else -> result.notImplemented()
        }
    }

    // ─── Permission ────────────────────────────────────────────────────────────

    private fun hasUsagePermission(): Boolean {
        val appOps = context.getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.checkOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS,
            android.os.Process.myUid(),
            context.packageName
        )
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun requestUsagePermission() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        context.startActivity(intent)
    }

    // ─── Core ──────────────────────────────────────────────────────────────────

    private fun buildScreenTimeReport(
        startMs: Long,
        endMs: Long,
        intervalSec: Int
    ): JSONObject {
        val intervalMs  = intervalSec * 1000L
        val generatedAt = System.currentTimeMillis()

        val intervalsArray = JSONArray()
        var cursor = startMs

        while (cursor < endMs) {
            val intervalEnd = minOf(cursor + intervalMs, endMs)
            val appsJson    = getAppsForInterval(cursor, intervalEnd)

            intervalsArray.put(JSONObject().apply {
                put("interval_start", toIso(cursor))
                put("interval_end",   toIso(intervalEnd))
                put("apps",           appsJson)
            })

            cursor = intervalEnd
        }

        return JSONObject().apply {
            put("meta", JSONObject().apply {
                put("query_start",      toIso(startMs))
                put("query_end",        toIso(endMs))
                put("interval_seconds", intervalSec)
                put("generated_at",     toIso(generatedAt))
            })
            put("intervals", intervalsArray)
        }
    }

    private fun getAppsForInterval(startMs: Long, endMs: Long): JSONObject {
        val usm         = context.getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val usageEvents = usm.queryEvents(startMs, endMs)
        val event       = UsageEvents.Event()

        data class RawEvent(val timestamp: Long, val type: Int)
        val rawMap = mutableMapOf<String, MutableList<RawEvent>>()

        while (usageEvents.hasNextEvent()) {
            usageEvents.getNextEvent(event)
            if (event.eventType == UsageEvents.Event.MOVE_TO_FOREGROUND ||
                event.eventType == UsageEvents.Event.MOVE_TO_BACKGROUND
            ) {
                rawMap.getOrPut(event.packageName) { mutableListOf() }
                    .add(RawEvent(event.timeStamp, event.eventType))
            }
        }

        val appsJson = JSONObject()

        for ((packageName, events) in rawMap) {
            val sorted = events.sortedBy { it.timestamp }
            val sessions = JSONArray()

            var foregroundTime  = 0L
            var backgroundTime  = 0L
            var openCount       = 0
            var closeCount      = 0
            var sessionStart    = 0L
            var backgroundStart = 0L

            for (e in sorted) {
                when (e.type) {
                    UsageEvents.Event.MOVE_TO_FOREGROUND -> {
                        // calculate background duration before this foreground
                        if (backgroundStart > 0) {
                            val bgDuration = e.timestamp - backgroundStart
                            backgroundTime += bgDuration
                            sessions.put(JSONObject().apply {
                                put("session_id", "sess-${UUID.randomUUID()}")
                                put("start_time", toIso(backgroundStart))
                                put("end_time",   toIso(e.timestamp))
                                put("duration",   bgDuration / 1000)
                                put("type",       "background")
                            })
                            backgroundStart = 0L
                        }
                        sessionStart = e.timestamp
                        openCount++
                    }
                    UsageEvents.Event.MOVE_TO_BACKGROUND -> {
                        // if sessionStart is 0, app was already open before interval started
                        val effectiveStart = if (sessionStart > 0) sessionStart else startMs
                        val fgDuration     = e.timestamp - effectiveStart
                        foregroundTime    += fgDuration
                        sessions.put(JSONObject().apply {
                            put("session_id", "sess-${UUID.randomUUID()}")
                            put("start_time", toIso(effectiveStart))
                            put("end_time",   toIso(e.timestamp))
                            put("duration",   fgDuration / 1000)
                            put("type",       "foreground")
                        })
                        // ✅ only count close if we saw the open within this interval
                        if (sessionStart > 0) closeCount++
                        sessionStart    = 0L
                        backgroundStart = e.timestamp
                    }
                }
            }

            // app was still in foreground at interval end
            if (sessionStart > 0) {
                val fgDuration = endMs - sessionStart
                foregroundTime += fgDuration
                sessions.put(JSONObject().apply {
                    put("session_id", "sess-${UUID.randomUUID()}")
                    put("start_time", toIso(sessionStart))
                    put("end_time",   toIso(endMs))
                    put("duration",   fgDuration / 1000)
                    put("type",       "foreground")
                })
            }

            // app was still in background at interval end
            if (backgroundStart > 0) {
                val bgDuration = endMs - backgroundStart
                backgroundTime += bgDuration
                sessions.put(JSONObject().apply {
                    put("session_id", "sess-${UUID.randomUUID()}")
                    put("start_time", toIso(backgroundStart))
                    put("end_time",   toIso(endMs))
                    put("duration",   bgDuration / 1000)
                    put("type",       "background")
                })
            }

            val appName = getAppName(packageName)

            appsJson.put(appName, JSONObject().apply {
                put("app_name",        appName)
                put("app_id",          packageName)
                put("foreground_time", foregroundTime / 1000)
                put("background_time", backgroundTime / 1000)
                put("total_time",      (foregroundTime + backgroundTime) / 1000)
                put("open_count",      openCount)
                put("close_count",     closeCount)
                put("sessions",        sessions)
            })
        }

        return appsJson
    }

    // ─── Helpers ───────────────────────────────────────────────────────────────

    private fun toIso(ms: Long): String =
        Instant.ofEpochMilli(ms)
            .atZone(ZoneId.systemDefault())
            .toOffsetDateTime()
            .toString()

    private fun getAppName(packageName: String): String {
        return try {
            val info = context.packageManager.getApplicationInfo(packageName, 0)
            context.packageManager.getApplicationLabel(info).toString()
        } catch (e: Exception) {
            packageName
        }
    }
}