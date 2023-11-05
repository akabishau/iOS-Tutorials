//
//  AppDelegate.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/1/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


	var window: UIWindow?
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		
		return true
	}
	
	
	// MARK: UISceneSession Lifecycle
	
	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

}

