import Flutter
import UIKit
import Firebase
import GoogleMaps
import workmanager_apple
import flutter_local_notifications

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        // Google Maps — read key from Info.plist (resolved from User-Defined Setting MAPS_API_KEY)
        let mapsApiKey = Bundle.main.object(forInfoDictionaryKey: "MAPS_API_KEY") as? String ?? ""
        if !mapsApiKey.isEmpty {
            GMSServices.provideAPIKey(mapsApiKey)
        } else {
            print("⚠️ MAPS_API_KEY missing from Info.plist — Google Maps will not work")
        }

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

    // MARK: - APNs Registration

    override func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        // Firebase swizzles this automatically when FirebaseAppDelegateProxyEnabled is true,
        // but calling super ensures the swizzle chain is not broken.
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("✅ APNs token: \(token)")
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    override func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("❌ APNs registration failed: \(error.localizedDescription)")
        super.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }

    // MARK: - Implicit Engine Delegate

    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    }
}
