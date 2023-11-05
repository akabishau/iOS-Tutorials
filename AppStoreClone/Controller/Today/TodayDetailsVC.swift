//
//  TodayDetailsVC.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/27/22.
//

import UIKit

class TodayDetailsVC: UIViewController {
	
	let tableView = UITableView(frame: .zero, style: .plain)
	
	private let closeButton: UIButton = {
		let button = UIButton(type: .system)
		let configuration = UIImage.SymbolConfiguration(weight: .heavy)
		button.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration), for: .normal)
		return button
	}()
	
	private let todayItem: TodayItem
	
	
	init(todayItem: TodayItem) {
		self.todayItem = todayItem
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureTableView()
		configureCloseButton()
	}
	
	
	// being called on today vc - animate view back to the size of cell and removes this vc from parent
	var dismissHandler: (() -> ())?
	
	
	@objc private func handleDismiss(_ sender: UIButton) {
		sender.isHidden = true
		dismissHandler?()
	}
	
	
	private func configureTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.tableFooterView = UIView()
		tableView.separatorStyle = .none
		tableView.allowsSelection = false
			
		view.addSubview(tableView)
		tableView.fillSuperview()
	}
	
	private func configureCloseButton() {
		view.addSubview(closeButton)
		closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 16))
		closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
	}
}


//MARK: - Table View
extension TodayDetailsVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}


	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if indexPath.row == 0 {
			let cell = TodayHeaderCell()
			cell.todayCell.todayItem = todayItem
			return cell
		}
		return TodayDescriptionCell()
	}
}


extension TodayDetailsVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		// set the size of the first cell to match original cell size, and let table view handle the height of the other cells
		return indexPath.row == 0 ? TodayVC.cellSize : UITableView.automaticDimension
	}
}
