//
//  PreviewVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/16/22.
//

import UIKit
import SDWebImage

class PreviewVC: BaseListVC {
	
	
	var appDetails: Result? {
		didSet {
			collectionView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.register(ScreenshotCell.self, forCellWithReuseIdentifier: ScreenshotCell.reuseId)
		
		collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
		if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
			layout.scrollDirection = .horizontal
		}
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return appDetails?.screenshotUrls.count ?? 0
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let screenshoutUrl = URL(string: appDetails?.screenshotUrls[indexPath.item] ?? "")
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCell.reuseId, for: indexPath) as! ScreenshotCell
		cell.imageView.sd_setImage(with: screenshoutUrl)
		return cell
	}
}


extension PreviewVC: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: 250, height: view.frame.height)
	}
}
