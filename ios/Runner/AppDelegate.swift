import Flutter
import UIKit
import google_mobile_ads

@main
@objc class AppDelegate: FlutterAppDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // 🔹 Required: register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // 🔹 Register Google Native Ad Factory
    let factory = FeedNativeAdFactory()

    FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
      self,
      factoryId: "feedNativeAd", // MUST match Dart factoryId
      nativeAdFactory: factory
    )

    return super.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
  }

  override func applicationWillTerminate(_ application: UIApplication) {
    // 🔹 Clean up (good practice)
    FLTGoogleMobileAdsPlugin.unregisterNativeAdFactory(
      self,
      factoryId: "feedNativeAd"
    )
  }
}
