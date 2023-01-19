//
//  NetworkLayer.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 15.01.2023.
//

import Foundation
import Alamofire

class NetworkLayer {
    private var url: String?
    
    private var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let apiKey = dict["API_KEY"] as? String else {
                  fatalError("API_KEY not found in Info.plist")
              }
        
        return apiKey
    }
    
    static func getInstance() -> NetworkLayer {
        return NetworkLayer()
    }
    
    private init() {}
    
    func url(_ url: String) -> NetworkLayer {
        self.url = url
        return self
    }

    func makeRequest<T: Decodable>(completion: @escaping (_ data: Result<T, Error>) -> Void) {
        guard let url = self.url else {
            return
        }

        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]

        guard let finalUrl = urlComponents?.url else {
            fatalError("Failed to add api_key to url")
        }

        AF.request(finalUrl)
            .validate()
            .responseDecodable(of: T.self) { (response) in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
