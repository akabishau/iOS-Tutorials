//
//  TodayItem.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 1/11/23.
//

import UIKit

struct TodayItem {
	
	let cellType: CellType
	let category: String
	let title: String
	let image: UIImage
	let description: String
	
	let backgroundColor: UIColor
	
	
	
	enum CellType: String {
		case single, multiple
	}
}
