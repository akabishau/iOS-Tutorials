//
//  AppsHeaderCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/12/22.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
	
	static let reuseId = String(describing: AppsHeaderCell.self)
	
	
	let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 14))
	let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
	let imageView = UIImageView(cornerRadius: 8)
	
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .systemBackground
		
//		imageView.backgroundColor = .systemRed
		companyLabel.textColor = .systemBlue
		titleLabel.numberOfLines = 2
		
		let stackView = UIStackView(arrangedSubviews: [companyLabel, titleLabel, imageView])
		stackView.axis = .vertical
		stackView.spacing = 8
		addSubview(stackView)
		stackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
