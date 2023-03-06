import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        
    GMSServices.provideAPIKey("AIzaSyAuGa03qaGIEIHgGI6M8OKn_SY2FvltYik")
    

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
