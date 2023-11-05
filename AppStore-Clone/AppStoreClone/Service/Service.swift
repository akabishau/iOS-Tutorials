//
//  Service.swift
//  AppStoreClone
//
//  Created by Aleksey Kabishau on 12/7/22.
//

import Foundation


class Service {
	
	static let shared = Service()
	
	//TODO: - Convert to generics as well
	func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
		print(#function)
		let stringUrl = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
		guard let url = URL(string: stringUrl) else { return }
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			// error case
			if let error = error  {
				print("failed to fetch app serch", error)
				completion([], error)
				return
			}
			
			// success
			guard let data = data else { return }
			
			do {
				let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
				completion(searchResult.results, nil)
			} catch {
				print("failed to decode:", error)
				completion([], error)
			}
		}.resume()
	}
	
	
	func fetchTopPaidApps(completion: @escaping (AppGroup?, Error?) -> Void) {
		let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"
		fetchGenericJSONData(urlString: urlString, completion: completion)
	}

	
	func fetchTopFreeApps(completion: @escaping (AppGroup?, Error?) -> Void) {
		let urlString = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
		fetchGenericJSONData(urlString: urlString, completion: completion)
	}
	
	
	func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
		let urlString = "https://api.letsbuildthatapp.com/appstore/social"
		fetchGenericJSONData(urlString: urlString, completion: completion)
	}
	
	
	func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
		
		guard let url = URL(string: urlString) else { return }
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(nil, error)
				return
			}
			
			do {
				let result = try JSONDecoder().decode(T.self, from: data!)
				completion(result, nil)
			} catch {
				completion(nil, error)
			}
		}.resume()
	}
}
