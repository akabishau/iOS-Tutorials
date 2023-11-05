//
//  AppDetailCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/15/22.
//

import UIKit
import SDWebImage

class AppDetailCell: UICollectionViewCell {
	
	static let reuseId = String(describing: AppDetailCell.self)
	
	var appDetails: Result? {
		didSet {
			nameLabel.text = appDetails?.trackName
			releaseNotesLabel.text = appDetails?.releaseNotes
			priceButton.setTitle(appDetails?.formattedPrice, for: .normal)
			appIconImageView.sd_setImage(with: URL(string: appDetails?.artworkUrl100 ?? ""))
		}
	}
	
	// initial setup using extensions methods
	let appIconImageView = UIImageView(cornerRadius: 16)
	let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
	let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
	let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
	let priceButton = UIButton(title: "$4.99")
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .systemTeal
		setUpViews()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func setUpViews() {
		appIconImageView.backgroundColor = .systemRed
		appIconImageView.constrainWidth(constant: 140)
		appIconImageView.constrainHeight(constant: 140)
		
		priceButton.backgroundColor = .systemBlue
		priceButton.constrainHeight(constant: 32)
		priceButton.constrainWidth(constant: 80)
		priceButton.layer.cornerRadius = 16
		priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		priceButton.setTitleColor(.white, for: .normal)
		priceButton.constrainWidth(constant: 80)
		
		
		let verticalStackView = UIStackView(arrangedSubviews: [nameLabel, priceButton, UIView()])
		verticalStackView.axis = .vertical
		verticalStackView.spacing = 12
		verticalStackView.alignment = .leading
		
		
		let horizontalStackView = UIStackView(arrangedSubviews: [appIconImageView, verticalStackView])
		horizontalStackView.axis = .horizontal
		horizontalStackView.spacing = 12
		
		let stackView = UIStackView(arrangedSubviews: [horizontalStackView, whatsNewLabel, releaseNotesLabel])
		stackView.axis = .vertical
		stackView.spacing = 16
		
		addSubview(stackView)
		stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
	}
}
