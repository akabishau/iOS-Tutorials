//
//  AppSearchVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/3/22.
//

import UIKit
import SDWebImage

class AppSearchVC: BaseListVC {
	
	
	fileprivate var appResults = [Result]()
	
	fileprivate let searchController = UISearchController(searchResultsController: nil)
	
	var timer: Timer?
	
	
	fileprivate let enterSearchTermLabel: UILabel = {
		let label = UILabel()
		label.text = "Please enter search term above"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 20)
		return label
	}()
		
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		collectionView.backgroundColor = .systemBackground
		collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.reuseId)
		
		collectionView.addSubview(enterSearchTermLabel)
		enterSearchTermLabel.fillSuperview(padding: UIEdgeInsets(top: 100, left: 50, bottom: 0, right: 50))
		
		setupSearchBar()
	}
	
	
	
	
	fileprivate func setupSearchBar() {
		definesPresentationContext = true // do I need to set this property and why?
		navigationItem.searchController = self.searchController
		navigationItem.hidesSearchBarWhenScrolling = false
//		searchController.obscuresBackgroundDuringPresentation = true // were freezing ui for some reason
		searchController.searchBar.delegate = self
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.reuseId, for: indexPath) as! SearchResultCell
		cell.appInfo = appResults[indexPath.item]
		return cell
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		enterSearchTermLabel.isHidden = !appResults.isEmpty
		return appResults.count
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let appDetailsVC = AppDetailsVC(appId: String(appResults[indexPath.item].trackId))
		navigationController?.pushViewController(appDetailsVC, animated: true)
	}
}


extension AppSearchVC: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: 350)
	}
}


extension AppSearchVC: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		//throttling the search - invalidate, then set the timer - is this a correct approach?
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
			Service.shared.fetchApps(searchTerm: searchText) { results, error in
				if let error = error {
					print("failed to fetch apps:", error)
					return
				}
				
				self.appResults = results
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			}
		})
	}
}
