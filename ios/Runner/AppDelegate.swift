import Flutter
import UIKit
import Firebase
import workmanager_apple
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Firebase
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }

        // Notifications
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        }
        application.registerForRemoteNotifications()

        // Plugin registrant callbacks for background isolates
        FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { registry in
            GeneratedPluginRegistrant.register(with: registry)
        }

        WorkmanagerPlugin.setPluginRegistrantCallback { registry in
            GeneratedPluginRegistrant.register(with: registry)
        }

        // Background tasks — identifiers must match BGTaskSchedulerPermittedIdentifiers in Info.plist
        let bundleId = Bundle.main.bundleIdentifier ?? "app"

        WorkmanagerPlugin.registerBGProcessingTask(
            withIdentifier: "\(bundleId).ios.processing_task"
        )

        WorkmanagerPlugin.registerPeriodicTask(
            withIdentifier: "\(bundleId).ios.periodic_task",
            frequency: NSNumber(value: 15 * 60)
        )

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    }
}
