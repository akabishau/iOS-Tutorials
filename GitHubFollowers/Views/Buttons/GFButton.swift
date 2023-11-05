//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/19/23.
//

import UIKit

class GFButton: UIButton {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	convenience init(backgroundColor: UIColor, title: String) {
		self.init(frame: .zero)
		self.backgroundColor = backgroundColor
		self.setTitle(title, for: .normal)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	func set(backgroundColor: UIColor, title: String) {
		self.backgroundColor = backgroundColor
		setTitle(title, for: .normal)
	}
	
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		layer.cornerRadius = 10
		setTitleColor(.white, for: .normal)
		titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
	}
}
