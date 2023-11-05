//
//  SearchResultCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/5/22.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
	
	static let reuseId = String(describing: SearchResultCell.self)
	
	// is it okay to force unwrap it this way?
	var appInfo: Result! {
		didSet {
			nameLabel.text = appInfo.trackName
			categoryLabel.text = appInfo.primaryGenreName
			ratingsLabel.text = "Rating: \(appInfo.averageUserRating ?? 0)"
			appIconImageView.sd_setImage(with: URL(string: appInfo.artworkUrl100))
			screenshot1ImageView.sd_setImage(with: URL(string: appInfo.screenshotUrls[0]))
			if appInfo.screenshotUrls.count > 2 {
				screenshot2ImageView.sd_setImage(with: URL(string: appInfo.screenshotUrls[1]))
			}
			if appInfo.screenshotUrls.count > 3 {
				screenshot3ImageView.sd_setImage(with: URL(string: appInfo.screenshotUrls[2]))
			}
		}
	}
	
	
	let appIconImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
		imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
		imageView.layer.cornerRadius = 12
		imageView.clipsToBounds = true
		return imageView
	}()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let categoryLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let ratingsLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let getButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("GET", for: .normal)
		button.setTitleColor(.blue, for: .normal)
		button.titleLabel?.font = .boldSystemFont(ofSize: 14)
		button.backgroundColor = UIColor(white: 0.95, alpha: 1)
		button.widthAnchor.constraint(equalToConstant: 80).isActive = true
		button.heightAnchor.constraint(equalToConstant: 32).isActive = true
		button.layer.cornerRadius = 12
		return button
	}()
	
	lazy var screenshot1ImageView = createScreenshotImageView()
	lazy var screenshot2ImageView = createScreenshotImageView()
	lazy var screenshot3ImageView = createScreenshotImageView()
	
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
		labelsStackView.axis = .vertical
		
		let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
		infoTopStackView.spacing = 12
		//TODO: - learn more about alignment property of the stack view
		infoTopStackView.alignment = .center
		
		let screenshotsStackView = UIStackView(arrangedSubviews: [screenshot1ImageView, screenshot2ImageView, screenshot3ImageView])
		screenshotsStackView.axis = .horizontal
		screenshotsStackView.spacing = 12
		screenshotsStackView.distribution = .fillEqually // only works when set this property - why?
		
		
		// distribution is .fill by default; the height of the info stack is determined from its intinsic size
		let overrallStackView = UIStackView(arrangedSubviews: [infoTopStackView, screenshotsStackView])
		overrallStackView.axis = .vertical
		overrallStackView.spacing = 16
		
		addSubview(overrallStackView)
		overrallStackView.fillSuperview(padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
	}
	
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	
	
	func createScreenshotImageView() -> UIImageView {
		
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 8
		imageView.clipsToBounds = true
		imageView.layer.borderWidth =  0.5
		imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
		imageView.contentMode = .scaleAspectFill
		return imageView
	}
}
