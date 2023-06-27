//
//  SongsModel.swift
//  iTunesTask
//
//  Created by Bakhtiyarov Fozilkhon on 26.06.2023.
//

import Foundation

struct SongsModel: Decodable {
    let results: [Song]
}

struct Song: Decodable {
    let trackName: String?
}
