//
//  Response.swift
//  CupcakeCorner
//
//  Created by Berserk on 22/05/2024.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
