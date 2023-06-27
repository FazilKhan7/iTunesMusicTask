//
//  NetworkRequest.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 25.06.2023.
//

import Foundation

class NetworkRequest {
    
    static let shared = NetworkRequest()
    
    private init() {}
    
    func requestData(urlString: String, comletion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    comletion(.failure(error))
                }
                
                if let data = data {
                    comletion(.success(data))
                }
            }
        }.resume()
    }
}
