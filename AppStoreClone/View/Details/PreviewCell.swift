//
//  PreviewCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/16/22.
//

import UIKit

class Previewcell: UICollectionViewCell {
	
	static let reuseId = String(describing: Previewcell.self)
	
	let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
	let previewVC = PreviewVC()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	private func setupViews() {
		previewLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(previewLabel)
		
		// for some reason layout through extension method didn't work properly - used this way
		let containerView = UIView()
		containerView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(containerView)
//		containerView.backgroundColor = .systemGray
		
		containerView.addSubview(previewVC.view)
		
		NSLayoutConstraint.activate([
			previewLabel.topAnchor.constraint(equalTo: topAnchor),
			previewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
			previewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
			previewLabel.heightAnchor.constraint(equalToConstant: 30),
			
			containerView.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 16),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
		containerView.addSubview(previewVC.view)
		previewVC.view.fillSuperview()
	}
}
