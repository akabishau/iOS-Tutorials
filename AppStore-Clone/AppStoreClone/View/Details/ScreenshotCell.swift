//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/16/22.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
	
	static let reuseId = String(describing: ScreenshotCell.self)
	
	let imageView = UIImageView(cornerRadius: 12)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(imageView)
		imageView.fillSuperview()
	}
	
	required init?(coder: NSCoder) {
	
		fatalError("init(coder:) has not been implemented")
	}
	}
