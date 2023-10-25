import UIKit
import Flutter
import CoreLocation  // CoreLocation 프레임워크를 import 해야 합니다.

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    let manager = CLLocationManager()  // CLLocationManager 객체 추가

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // CLLocationManager 관련 코드
        if (CLLocationManager.locationServicesEnabled()) {
            switch CLLocationManager.authorizationStatus() {
            case .denied, .notDetermined, .restricted:
                self.manager.requestAlwaysAuthorization()
                break
            default:
                break
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
