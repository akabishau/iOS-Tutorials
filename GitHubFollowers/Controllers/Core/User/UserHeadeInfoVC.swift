//
//  UserHeaderVC.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 2/23/23.
//

import UIKit

final class UserHeadeInfoVC: UIViewController {
	
	let avatarImageView = GFAvatarImageView(frame: .zero)
	let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
	let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
	let locationImageView = UIImageView()
	let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
	let bioLabel = GFBodyLabel(textAlignment: .left)
	
	
	
	var user: User
	
	init(user: User) {
		self.user = user
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		addSubViews()
		configureUIElements()
		layoutUI()
	}
	
	
	private func addSubViews() {
		view.addSubview(avatarImageView)
		view.addSubview(usernameLabel)
		view.addSubview(nameLabel)
		view.addSubview(locationImageView)
		view.addSubview(locationLabel)
		view.addSubview(bioLabel)
	}
	
	
	private func configureUIElements() {
		avatarImageView.downloadImage(from: user.avatarUrl)
		usernameLabel.text = user.login
		nameLabel.text = user.name ?? ""
		locationImageView.image = SFSymbols.location
		locationImageView.tintColor = .secondaryLabel // sfsymbols blue by default
		locationLabel.text = user.location ?? "No Location"
		bioLabel.text = user.bio ?? "No bio available"
		bioLabel.numberOfLines = 3
	}
	
	
	private func layoutUI() {
		let padding: CGFloat = 12
		locationImageView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			
			avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			avatarImageView.widthAnchor.constraint(equalToConstant: 90),
			avatarImageView.heightAnchor.constraint(equalToConstant: 90),
			
			usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
			usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
			usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			usernameLabel.heightAnchor.constraint(equalToConstant: 38), // font + 4
			
			nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8), // design choice
			nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
			nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			nameLabel.heightAnchor.constraint(equalToConstant: 20),
			
			locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
			locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
			locationImageView.widthAnchor.constraint(equalToConstant: 20),
			locationImageView.heightAnchor.constraint(equalToConstant: 20),
			
			locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
			locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
			locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			locationLabel.heightAnchor.constraint(equalToConstant: 20),
			
			bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
			bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
			bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			//TODO: - Consider dynamic height based on content size
			bioLabel.heightAnchor.constraint(equalToConstant: 80)
		])
	}
}
