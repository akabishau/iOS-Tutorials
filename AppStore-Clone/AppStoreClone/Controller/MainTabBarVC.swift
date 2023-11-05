//
//  MainTabBarVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/3/22.
//

import UIKit

class MainTabBarVC: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBackground

		viewControllers = [
			createNavController(for: TodayVC(), title: "Today", imageName: "doc.text.image"),
			createNavController(for: AppsPageVC(), title: "Apps", imageName: "house"),
			createNavController(for: AppSearchVC(), title: "Search", imageName: "magnifyingglass"),
		]
	}
	
	
	fileprivate func createNavController(for viewController: UIViewController, title: String, imageName: String) -> UIViewController {
		
		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.tabBarItem.title = title
		navigationController.tabBarItem.image = UIImage(systemName: imageName)
		navigationController.navigationBar.prefersLargeTitles = true
		
		viewController.navigationItem.title = title

		return navigationController
	}
}
