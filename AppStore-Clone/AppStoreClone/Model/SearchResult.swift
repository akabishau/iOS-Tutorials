//
//  SearchResult.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/7/22.
//

import Foundation


struct SearchResult: Decodable {
	let resultCount: Int
	let results: [Result]
}


struct Result: Decodable {
	let trackId: Int
	let trackName: String
	let primaryGenreName: String
	let averageUserRating: Double?
	var screenshotUrls: [String]
	let artworkUrl100: String
	var formattedPrice: String?
	var description: String
	var releaseNotes: String?
	var artistName: String
}
