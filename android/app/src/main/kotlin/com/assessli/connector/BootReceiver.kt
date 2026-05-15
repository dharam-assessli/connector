package com.assessli.connector

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import androidx.work.*
import java.util.concurrent.TimeUnit

class BootReceiver : BroadcastReceiver() {

    data class WorkerConfig(
        val workerClass: Class<out ListenableWorker>,
        val dartTaskKey: String
    )

    override fun onReceive(context: Context, intent: Intent) {
        if (
            intent.action == Intent.ACTION_BOOT_COMPLETED ||
            intent.action == Intent.ACTION_MY_PACKAGE_REPLACED
        ) {
            Log.d("BootReceiver", "Re-registering WorkManager tasks")
            registerTasks(context)
        }
    }

    private fun resolveWorkerConfig(): WorkerConfig? {
        val candidates = listOf(
            "dev.fluttercommunity.workmanager.BackgroundWorker" to "dev.fluttercommunity.workmanager.DART_TASK",
            "be.tramckrijte.workmanager.BackgroundWorker"       to "be.tramckrijte.workmanager.DART_TASK"
        )
        for ((className, dartTaskKey) in candidates) {
            try {
                val workerClass = Class.forName(className).asSubclass(ListenableWorker::class.java)
                Log.d("BootReceiver", "Resolved worker: $className")
                return WorkerConfig(workerClass, dartTaskKey)
            } catch (e: ClassNotFoundException) {
                Log.w("BootReceiver", "Worker class not found: $className")
            }
        }
        return null
    }

    private fun registerTasks(context: Context) {
        val config = resolveWorkerConfig() ?: run {
            Log.e("BootReceiver", "No WorkManager worker class found. Aborting.")
            return
        }

        val workManager = WorkManager.getInstance(context)

        val constraints = Constraints.Builder()
            .setRequiredNetworkType(NetworkType.NOT_REQUIRED)
            .setRequiresBatteryNotLow(false)
            .setRequiresCharging(false)
            .setRequiresDeviceIdle(false)
            .setRequiresStorageNotLow(false)
            .build()

        // One-off task
        val oneOffRequest = OneTimeWorkRequest.Builder(config.workerClass)
            .setConstraints(constraints)
            .setInputData(workDataOf(config.dartTaskKey to "androidOneOffTask"))
            .build()

        workManager.enqueueUniqueWork(
            "androidOneOffTask",
            ExistingWorkPolicy.KEEP,
            oneOffRequest
        )

        // Periodic task
        val periodicRequest = PeriodicWorkRequest.Builder(
            config.workerClass,
            30, TimeUnit.MINUTES
        )
            .setConstraints(constraints)
            .setInputData(workDataOf(config.dartTaskKey to "androidPeriodicTask"))
            .build()

        workManager.enqueueUniquePeriodicWork(
            "androidPeriodicTask",
            ExistingPeriodicWorkPolicy.KEEP,
            periodicRequest
        )

        Log.d("BootReceiver", "Tasks re-registered successfully")
    }
}
