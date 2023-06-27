//
//  NetworkDataFetch.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 25.06.2023.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchAlbum(urlString: String, completion: @escaping (AlbumModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            
            switch result {
                
            case .success(let data):
                let parsedData = self.parseJson(data: data)
                completion(parsedData, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func fetchSongs(urlString: String, completion: @escaping (SongsModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: urlString) { result in
            
            switch result {
                
            case .success(let data):
                let parsedData = self.parseJsonSong(data: data)
                completion(parsedData, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    private func parseJson(data: Data) -> AlbumModel? {
        do {
            let decoder = JSONDecoder()
            let decodedJson = try decoder.decode(AlbumModel.self, from: data)
            return decodedJson
        } catch let jsonError {
            print("Error", jsonError)
        }
        return nil
    }
    
    private func parseJsonSong(data: Data) -> SongsModel? {
        do {
            let decoder = JSONDecoder()
            let decodedJson = try decoder.decode(SongsModel.self, from: data)
            return decodedJson
        } catch let jsonError {
            print("Error", jsonError)
        }
        return nil
    }
}
