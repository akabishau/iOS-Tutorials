//
//  BaseTodayCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 1/12/23.
//

import UIKit

class BaseTodayCell: UICollectionViewCell {
	
	var todayItem: TodayItem!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	
	required init?(coder: NSCoder) { fatalError() }
}
