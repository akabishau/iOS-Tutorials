//
//  TodayCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/25/22.
//

import UIKit

class TodaySingleAppCell: BaseTodayCell {
	
	override var todayItem: TodayItem! {
		didSet {
			categoryLabel.text = todayItem.category
			titleLabel.text = todayItem.title
			imageView.image = todayItem.image
			descriptionLabel.text = todayItem.description
			backgroundColor = todayItem.backgroundColor
		}
	}
	
	
	let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
	let titleLabel = UILabel(text: "Utilizing your Time", font: .boldSystemFont(ofSize: 26))
	let imageView = UIImageView(image: UIImage(named: "garden"))
	let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 18), numberOfLines: 3)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setUpViews()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		categoryLabel.text = nil
		titleLabel.text = nil
		imageView.image = nil
		descriptionLabel.text = nil
	}
	
	
	private func setUpViews() {
		
		backgroundColor = .systemBackground
		layer.cornerRadius = 16
		clipsToBounds = true
		
		let imageContainerView = UIView()
		imageContainerView.addSubview(imageView)
		imageView.centerInSuperview(size: .init(width: 240, height: 240))
		imageView.contentMode = .scaleAspectFill
		
		let stackView = UIStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel])
		addSubview(stackView)
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
	}
}
