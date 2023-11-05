//
//  TodayHeaderCell.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 1/10/23.
//

import UIKit


class TodayHeaderCell: UITableViewCell {
	
	let todayCell = TodaySingleAppCell() // use existing collection view cell and add it inside the table view cell
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		addSubview(todayCell)
		todayCell.fillSuperview()
	}
	
	required init?(coder: NSCoder) { fatalError() }
}
