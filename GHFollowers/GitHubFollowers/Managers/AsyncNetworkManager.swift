//
//  AsyncNetworkManager.swift
//  GitHubFollowers
//
//  Created by Aleksey Kabishau on 3/29/23.
//

import UIKit

class AsyncNetworkManager {
	
	static let shared = AsyncNetworkManager()
	
	private let baseURL = "https://api.github.com/users/"
	private let cache = NSCache<NSString, UIImage>()
	
	private let decoder = JSONDecoder()
	
	private init() {
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		decoder.dateDecodingStrategy = .iso8601
	}
	
	
	func getFollowers(for username: String, page: Int) async throws -> [Follower] {
		let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
		guard let url = URL(string: endpoint) else { throw GFError.invalidUsername }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
			throw GFError.invalidResponse
		}
		
		do {
			return try decoder.decode([Follower].self, from: data)
		} catch {
			throw GFError.invalidData
		}
	}
	
	
	func getUserInfo(for username: String) async throws -> User {
		let endPoint = baseURL + username
		guard let url = URL(string: endPoint) else { throw GFError.invalidUsername }
		
		let (data, response) = try await URLSession.shared.data(from: url)
		guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GFError.invalidResponse }
		
		do {
			return try decoder.decode(User.self, from: data)
		} catch {
			throw GFError.invalidData
		}
	}
	
	
	// original version was written using result type - no need to do it here
	func downloadImage(from urlString: String) async -> UIImage? {
		
		let cacheKey = NSString(string: urlString)
		if let image = cache.object(forKey: cacheKey) { return image }
		
		guard let url = URL(string: urlString) else { return nil }
		
		// do-catch is not required in this case
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			guard let image = UIImage(data: data) else { return nil }
			cache.setObject(image, forKey: cacheKey)
			return image
		} catch {
			return nil
		}
	}
}
