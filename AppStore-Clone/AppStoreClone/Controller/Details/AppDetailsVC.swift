//
//  AppDetailsVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/14/22.
//

import UIKit

class AppDetailsVC: BaseListVC {
	
	private var appDetails: Result?
	private var reviews: ReviewResult?
	
	// dependency injection setup
	private let appId: String

	init(appId: String) {
		self.appId = appId
		super.init()
	}
	
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.largeTitleDisplayMode = .never
		
		collectionView.backgroundColor = .systemBackground
		collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.reuseId)
		collectionView.register(Previewcell.self, forCellWithReuseIdentifier: Previewcell.reuseId)
		collectionView.register(ReviewRatingCell.self, forCellWithReuseIdentifier: ReviewRatingCell.reuseId)
		
		fetchData()
	}
	
	
	private func fetchData() {
		let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
		Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, error) in
			if let error = error {
				print("error fetching app details", error)
				return
			}
			
			if let appDetails = result?.results.first {
				self.appDetails = appDetails
			}
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
		
		
		let reviewUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
		Service.shared.fetchGenericJSONData(urlString: reviewUrl) { (reviews: ReviewResult?, error) in
			
			if let error = error {
				print("failed to decode reviews: ", error)
				return
			}
			
			
			self.reviews = reviews
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
}


extension AppDetailsVC {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if indexPath.item  == 0 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.reuseId, for: indexPath) as! AppDetailCell
			cell.appDetails = appDetails
			return cell
		} else if indexPath.item == 1 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Previewcell.reuseId, for: indexPath) as! Previewcell
			cell.previewVC.appDetails = appDetails
			return cell
		} else if indexPath.item == 2 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewRatingCell.reuseId, for: indexPath) as! ReviewRatingCell
			cell.reviewsVC.reviews = self.reviews
			return cell
		} else {
			return UICollectionViewCell()
		}
	}
}


extension AppDetailsVC: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		var height: CGFloat = 280
		
		if indexPath.item == 0 {
			// cell auto-size calculation
			let dummyCell = AppDetailCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1000)) // 1000 is arbitrary number
			dummyCell.appDetails = appDetails
			dummyCell.layoutIfNeeded()
			
			let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
			//		print("Auto-sizing: \(estimatedSize)")
			height = estimatedSize.height
		} else if indexPath.item == 1 {
			height = 500
		} else if indexPath.item == 2 {
			height = 260
		}
		
		return .init(width: view.frame.width, height: height)
	}
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 0, left: 0, bottom: 16, right: 0)
	}
}
