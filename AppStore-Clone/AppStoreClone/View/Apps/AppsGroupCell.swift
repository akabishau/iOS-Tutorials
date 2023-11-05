//
//  AppsGroupCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/8/22.
//

import UIKit


class AppsGroupCell: UICollectionViewCell {
	
	static let reuseId = String(describing: AppsGroupCell.self)
	
	let horizontalController = AppsHorizontalVC()
	
	let titleLabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 30))
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .systemBackground
		
		addSubview(titleLabel)
		titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
		
		
		addSubview(horizontalController.view)
		horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
