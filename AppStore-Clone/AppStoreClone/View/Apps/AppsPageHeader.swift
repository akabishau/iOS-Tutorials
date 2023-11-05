//
//  AppsPageHeader.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/12/22.
//

import UIKit

class AppsPageHeader: UICollectionReusableView {
	
	static let reuseId = String(describing: AppsPageHeader.self)
	
	let appsHeaderVC = AppsHeaderVC()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(appsHeaderVC.view)
		appsHeaderVC.view.fillSuperview()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
