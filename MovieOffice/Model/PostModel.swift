//
//  PostModel.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/02.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

/*
 {
  rating: 10,
  writer: "두근반 세근반",
  movie_id: "5a54c286e8a71d136fb5378e",
  contents: "정말 다섯 번은 넘게 운듯 ㅠㅠㅠ 감동 쩔어요. 꼭 보셈 두 번 보셈"
 }
 */

import Foundation

struct PostModel: Codable {
    var rating: Int
    var writer: String
    var movieId: String
    var contents: String
    
    enum CodingKeys: String, CodingKey {
        case rating = "rating"
        case writer = "writer"
        case movieId = "movie_id"
        case contents = "contents"
    }
}
