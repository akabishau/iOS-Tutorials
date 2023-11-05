//
//  AppsHorizontalVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/8/22.
//

import UIKit
import SDWebImage

class AppsHorizontalVC: BaseListVC {
	
	let sellLineSpacing: CGFloat = 10
	let sectionVerticalPadding: CGFloat = 12
	let sectionHorizontalPading: CGFloat = 16
	
	var appGroup: AppGroup?
	
	// example of using a closure to pass data instead of initiating details vc from this vc
	// what are the down side of initiating details directly from here
	// can init nav controller by tapping cell
	var didSelectCellHander: ((FeedResult) -> ())?
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppRowCell.reuseId)
		
		if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
			layout.scrollDirection = .horizontal
		}
	}
}


extension AppsHorizontalVC {
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let app = appGroup?.feed.results[indexPath.item] {
			didSelectCellHander?(app)
		}
	}
}


extension AppsHorizontalVC {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return appGroup?.feed.results.count ?? 0
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let app = appGroup?.feed.results[indexPath.item]
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCell.reuseId, for: indexPath) as! AppRowCell
		
		cell.nameLabel.text = app?.name
		cell.companyLabel.text = app?.artistName
		cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
		return cell
	}
}


extension AppsHorizontalVC: UICollectionViewDelegateFlowLayout {
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		// the height is decreased with arbitrary number of 3 to fix autolayout issue with the last controller (total height is larger than collection view height)
		let cellHeight = (view.frame.height - 2 * sectionVerticalPadding - 2 * sellLineSpacing) / 3 - 3
		return CGSize(width: view.frame.width - 48, height: cellHeight)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: sectionVerticalPadding, left: sectionHorizontalPading, bottom: sectionVerticalPadding, right: sectionHorizontalPading)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return sellLineSpacing
	}
}

