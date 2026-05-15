// ignore_for_file: avoid_print

import "dart:convert";
import "dart:io";

import "package:firebase_functions/firebase_functions.dart";
import "package:http/http.dart" as http;

const String topic = "automated_task_trigger";

String get projectId {
  final String? id = Platform.environment["GCLOUD_PROJECT"];

  if (id == null || id.isEmpty) {
    throw Exception("Could not determine Firebase project ID from environment");
  }

  return id;
}

Future<void> main() async {
  await runFunctions((Firebase firebase) {
    firebase.https.onRequest(
      name: "helloWorld",
      options: const HttpsOptions(
        cors: Cors(<String>["*"]),
        maxInstances: Instances(10),
      ),
      (Request request) async {
        Response response = Response(500);

        try {
          response = Response(200, body: "Hello from Dart Functions!");
        } on Exception catch (error, stackTrace) {
          print("Exception | error: $error, stackTrace: $stackTrace");
          response = Response(500, body: "Failed to process request.");
        } finally {}

        return response;
      },
    );

    firebase.https.onRequest(
      name: "triggerNow",
      options: const HttpsOptions(
        cors: Cors(<String>["*"]),
        maxInstances: Instances(10),
      ),
      (Request request) async {
        Response response = Response(500);

        try {
          await sendFcmTrigger();

          response = Response(200, body: "Trigger sent successfully!");
        } on Exception catch (error, stackTrace) {
          print("Exception | error: $error, stackTrace: $stackTrace");
          response = Response(500, body: "Failed to process request.");
        } finally {}

        return response;
      },
    );

    // // ignore: experimental_member_use
    // firebase.scheduler.onSchedule(
    //   (ScheduledEvent event) async {
    //     try {
    //       print("Scheduler fired at: ${DateTime.now().toIso8601String()}");
    //       await sendFcmTrigger();
    //     } on Exception catch (error, stackTrace) {
    //       print("Exception | error: $error, stackTrace: $stackTrace");
    //     } finally {}
    //   },
    //   schedule: "every 1 minutes",
    //   options: const ScheduleOptions(timeZone: TimeZone("Asia/Kolkata")),
    // );
  });
}

Future<String> getAccessToken() async {
  String value = "";

  try {
    const String url =
        "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token";

    final http.Response res = await http.get(
      Uri.parse(url),
      headers: <String, String>{"Metadata-Flavor": "Google"},
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final Map<String, dynamic> data = jsonDecode(res.body);
      value = (data["access_token"] as String?) ?? "";
      print("Access token retrieved success [${res.statusCode}]: ${res.body}");
    } else {
      print("Access token retrieval failure [${res.statusCode}]: ${res.body}");
    }
  } on Exception catch (error, stackTrace) {
    print("Exception | error: $error, stackTrace: $stackTrace");
  } finally {}

  return Future<String>.value(value);
}

Future<bool> sendFcmTrigger() async {
  bool value = false;

  try {
    final String accessToken = await getAccessToken();

    if (accessToken.isEmpty) {
      print("No access token available, cannot send FCM trigger");

      return Future<bool>.value(false);
    }

    final String url =
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";

    final http.Response res = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode(<String, dynamic>{
        "message": <String, dynamic>{
          "topic": topic,
          "notification": <String, String>{
            "title": "Automation Running",
            "body": "Background sync in progress",
          },
          "data": <String, String>{
            "task": "run_automation",
            "timestamp": DateTime.now().toIso8601String(),
          },
          "android": <String, Object>{
            "priority": "HIGH",
            "notification": <String, Object>{
              "channel_id": "high_importance_channel",
              "default_sound": true,
              "default_vibrate_timings": true,
            },
          },
          "apns": <String, Map<String, Object>>{
            "headers": <String, String>{
              "apns-priority": "10",
              "apns-push-type": "alert",
            },
            "payload": <String, Map<String, Object>>{
              "aps": <String, Object>{
                "alert": <String, String>{
                  "title": "Automation Running",
                  "body": "Background sync in progress",
                },
                "sound": "default",
                "badge": 1,
                "interruption-level": "active",
              },
            },
          },
        },
      }),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      value = true;
      print("FCM trigger sent success [${res.statusCode}]: ${res.body}");
    } else {
      print("FCM trigger sent failure [${res.statusCode}]: ${res.body}");
    }
  } on Exception catch (error, stackTrace) {
    print("Exception | error: $error, stackTrace: $stackTrace");
  } finally {}

  return Future<bool>.value(value);
}
