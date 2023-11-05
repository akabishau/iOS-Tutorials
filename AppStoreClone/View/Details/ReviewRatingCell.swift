//
//  ReviewsCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/17/22.
//

import UIKit

class ReviewRatingCell: UICollectionViewCell {
	
	static let reuseId = String(describing: ReviewRatingCell.self)
	
	let reviewsRatingLabel = UILabel(text: "Review & Ratings", font: .boldSystemFont(ofSize: 20))
	let reviewsVC = ReviewsVC()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setUpViews()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func setUpViews() {
		reviewsRatingLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(reviewsRatingLabel)
		
		// for some reason layout through extension method didn't work properly - used this way
		let containerView = UIView()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(containerView)
		
		containerView.addSubview(reviewsVC.view)
		reviewsVC.view.fillSuperview()
				
		NSLayoutConstraint.activate([
			reviewsRatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			reviewsRatingLabel.topAnchor.constraint(equalTo: topAnchor),
			reviewsRatingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			reviewsRatingLabel.heightAnchor.constraint(equalToConstant: 30),
			
			containerView.topAnchor.constraint(equalTo: reviewsRatingLabel.bottomAnchor, constant: 16),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
		
		])
		
		
	}
}
