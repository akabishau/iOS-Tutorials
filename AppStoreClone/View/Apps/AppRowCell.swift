//
//  AppRowCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/9/22.
//

import UIKit


class AppRowCell: UICollectionViewCell {
	
	static let reuseId = String(describing: AppRowCell.self)
	
	let imageView: UIImageView = UIImageView(cornerRadius: 8)
	let nameLabel: UILabel = UILabel(text: "App Name", font: .systemFont(ofSize: 16))
	let companyLabel: UILabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
	let getButton: UIButton = UIButton(title: "GET")
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func setupViews() {
		
		let infoStackView = UIStackView(arrangedSubviews: [nameLabel, companyLabel])
		infoStackView.axis = .vertical
		infoStackView.spacing = 4
		
		
		let stackView = UIStackView(arrangedSubviews: [imageView, infoStackView, getButton])
		stackView.spacing = 16
		stackView.alignment = .center
		
		addSubview(stackView)
		stackView.fillSuperview()
		
		imageView.backgroundColor = .systemGray
		imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
		
		getButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
		getButton.constrainWidth(constant: 80)
		getButton.constrainHeight(constant: 32)
		getButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
		getButton.layer.cornerRadius = 32 / 2
	}
}
