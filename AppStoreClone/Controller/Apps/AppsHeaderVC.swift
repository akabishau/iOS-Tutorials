//
//  AppsHeaderVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/12/22.
//

import UIKit
import SDWebImage

class AppsHeaderVC: BaseListVC {
	
	var apps = [SocialApp]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.backgroundColor = .systemBackground
		collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: AppsHeaderCell.reuseId)
		
		if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
			layout.scrollDirection = .horizontal
		}
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return apps.count
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let app = apps[indexPath.item]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsHeaderCell.reuseId, for: indexPath) as! AppsHeaderCell
		cell.companyLabel.text = app.name
		cell.titleLabel.text = app.tagline
		cell.imageView.sd_setImage(with: URL(string: app.imageUrl))
		return cell
	}
}

extension AppsHeaderVC: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width - 48, height: view.frame.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		
		return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
	}
}
