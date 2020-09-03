//
//  CommentModel.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/01.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

/*
 "comments": [
    {
        "contents": "z z z z z z z zz z ",
        "id": "5f2a47071b865e40164e4c06",
        "writer": "gg",
        "movie_id": "5a54be21e8a71d136fb536a1",
        "rating": 9,
        "timestamp": 1596606215
    },
 */

import Foundation

struct CommentModel: Codable {
    
    let comments: [Comments]
    
}

struct Comments: Codable {
    
    var contents: String
    var id: String
    var writer: String
    var movieId: String
    var rating: Double
    var timestamp: Double
    
    enum CodingKeys: String, CodingKey {
        
        case contents = "contents"
        case id = "id"
        case writer = "writer"
        case movieId = "movie_id"
        case rating = "rating"
        case timestamp = "timestamp"
    }
}
