//
//  AppsListCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 1/12/23.
//

import UIKit

class TodayListAppCell: BaseTodayCell {
	
	override var todayItem: TodayItem! {
		didSet {
			categoryLabel.text = todayItem.category
			titleLabel.text = todayItem.title
		}
	}
	
	let categoryLabel = UILabel(text: "THE DAILY LIST", font: .boldSystemFont(ofSize: 20))
	let titleLabel = UILabel(text: "Test-Drive These CarPlay Apps", font: .boldSystemFont(ofSize: 26))
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpViews()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func setUpViews() {
		
		backgroundColor = .systemBackground
		layer.cornerRadius = 16
		
		
		let viewController = UIViewController()
		viewController.view.backgroundColor = .systemYellow
		
		let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, viewController.view])
		stackView.axis = .vertical
		stackView.spacing = 12
		
		addSubview(stackView)
		stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
	}
}
