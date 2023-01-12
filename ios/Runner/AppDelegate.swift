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
        
    GMSServices.provideAPIKey("YAIzaSyDhAumqNyZ7LfJhoSKJC8IAxKjQ_gVYtBg")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
