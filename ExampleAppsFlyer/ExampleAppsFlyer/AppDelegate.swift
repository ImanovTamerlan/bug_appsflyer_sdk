//
//  AppDelegate.swift
//  ExampleAppsFlyer
//
//  Created by Tamerlan Imanov on 17.03.2023.
//

import UIKit
import AppsFlyerLib

enum Environment {
    static let appsFlyerDevKey = "Ku8JkZEF9RJYwd4TQBXijm"
    static let appleAppID = "1541641406"
    static var appsFlyerOneLinkCustomDomains = ["click.tele2.kz"]
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppsFlyerLib.shared().deepLinkDelegate = self
        AppsFlyerLib.shared().start()
        AppsFlyerLib.shared().appsFlyerDevKey = Environment.appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = Environment.appleAppID
        AppsFlyerLib.shared().oneLinkCustomDomains = Environment.appsFlyerOneLinkCustomDomains
        AppsFlyerLib.shared().isDebug = true
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        AppsFlyerLib.shared().start()
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        NotificationCenter.default.post(name: .processing, object: nil, userInfo: nil)
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
}

extension AppDelegate: DeepLinkDelegate {
    
    func didResolveDeepLink(_ result: DeepLinkResult) {
        let userInfo = ["info": result]
        NotificationCenter.default.post(name: .didReceiveDeepLink, object: nil, userInfo: userInfo)
    }
}
