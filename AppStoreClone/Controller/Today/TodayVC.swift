//
//  TodayVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/25/22.
//

import UIKit

class TodayVC: BaseListVC {
	
	let items = [
		TodayItem(cellType: .single, category: "LIFE HACK", title: "Utilizing your Time", image: UIImage(named: "garden")!, description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .systemBackground),
		TodayItem(cellType: .multiple, category: "THE DAILY LIST", title: "Test-Drive These CarPlay", image: UIImage(named: "garden")!, description: "", backgroundColor: .systemBackground),
		TodayItem(cellType: .single, category: "HOLIDAYS", title: "Travel on a Budget", image: UIImage(named: "holiday")!, description: "Find out all you need to know how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9822810292, green: 0.9652379155, blue: 0.7222837806, alpha: 1))
	]
	
	
	var todayDetailsVC: TodayDetailsVC!
	
	var startingFrame: CGRect?
	var topConstraint: NSLayoutConstraint?
	var leadingConstraint: NSLayoutConstraint?
	var widthConstraint: NSLayoutConstraint?
	var heightConstraint: NSLayoutConstraint?
	
	
	static let cellSize: CGFloat = 450
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationController?.isNavigationBarHidden = true
		
		collectionView.backgroundColor = .lightGray
		collectionView.register(TodaySingleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
		collectionView.register(TodayListAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
		
		collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let fullscreenVC = TodayDetailsVC(todayItem: items[indexPath.item])
		fullscreenVC.dismissHandler = { [weak self] in
			self?.handleRemovalFullscreenView()
		}
		
		// create vc -> link view to vc's view, configure view, -> add view to hierarchy -> add child vc to current vc
		let fullScreenView = fullscreenVC.view!
		fullScreenView.layer.cornerRadius = 16 // to match cell corner radius?
		fullScreenView.clipsToBounds = true
		
		view.addSubview(fullScreenView)
		addChild(fullscreenVC) //without it table vc doesn't run its methods
		
		self.todayDetailsVC = fullscreenVC
		
		self.collectionView.isUserInteractionEnabled = false
		
		guard let cell = collectionView.cellForItem(at: indexPath) else { return }
		guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
		self.startingFrame = startingFrame
		
		
		// autolayout constraints animation approach (layout view, save constraints, animate constants update)
		fullScreenView.translatesAutoresizingMaskIntoConstraints = false
		topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
		leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
		widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
		heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
		
		[topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({ $0?.isActive = true })
		self.view.layoutIfNeeded()
		

		// 4 animate to the final position
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut) {
			
			self.topConstraint?.constant = 0
			self.leadingConstraint?.constant = 0
			self.widthConstraint?.constant = self.view.frame.width
			self.heightConstraint?.constant = self.view.frame.height
			
			self.view.layoutIfNeeded() // starts animation
			
			self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height
		}
	}
	
	
	@objc private func handleRemovalFullscreenView() {
		
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
			guard let startingFrame = self.startingFrame else { return }
			self.topConstraint?.constant = startingFrame.origin.y
			self.leadingConstraint?.constant = startingFrame.origin.x
			self.widthConstraint?.constant = startingFrame.width
			self.heightConstraint?.constant = startingFrame.height
			
			self.view.layoutIfNeeded()
			
			// somehow fixes the jumping animation
			self.todayDetailsVC.tableView.contentOffset = .zero
			
			if let tabBarFrame = self.tabBarController?.tabBar.frame {
				self.tabBarController?.tabBar.frame.origin.y = self.view.frame.size.height - tabBarFrame.height
			}
			
		}, completion: { _ in
			self.todayDetailsVC.view.removeFromSuperview()
			self.todayDetailsVC.removeFromParent()
			self.collectionView.isUserInteractionEnabled = true
		})
	}
}

//MARK: - Collection View Delegate


//MARK: - Collection View Data Source
extension TodayVC {
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cellId = items[indexPath.item].cellType.rawValue
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
		cell.todayItem = items[indexPath.item]
		return cell
	}
}


extension TodayVC: UICollectionViewDelegateFlowLayout {
	
	// width calculation pushes cells 32 points from the left and right
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return .init(width: collectionView.frame.width - 64, height: Self.cellSize)
	}
	
	// set the space between items - default is 10
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 32
	}
	
	// set top and bottom paddings for the items in the section
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 32, left: 0, bottom: 32, right: 0)
	}
}
