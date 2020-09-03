//
//  NetWorkModel.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/30.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import Foundation

struct Model: Codable {
    let movies: [MovieModel]
}

struct MovieModel: Codable {
    
    var title: String
    var date: String
    var reservationRate: Double
    var reservationGreade: Int
    var thumb: String
    var id: String
    var grade: Int
    var userRating: Double
    
    enum CodingKeys: String, CodingKey {
        case reservationRate = "reservation_rate"
        case reservationGreade = "reservation_grade"
        case userRating = "user_rating"
        case title = "title"
        case date = "date"
        case thumb = "thumb"
        case id = "id"
        case grade = "grade"
    }
    
}
