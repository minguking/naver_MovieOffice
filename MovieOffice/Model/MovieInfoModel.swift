//
//  MovieInfoModel.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/31.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

/*
 "audience": 11676822,
 "title": "신과함께-죄와벌",
 "date": "2017-12-20",
 "reservation_rate": 35.5,
 "reservation_grade": 1,
 "genre": "판타지, 드라마",
 "director": "김용화",
 "id": "5a54c286e8a71d136fb5378e",
 "duration": 139,
 "grade": 12,
 "actor": "하정우(강림), 차태현(자홍), 주지훈(해원맥), 김향기(덕춘)",
 "image": "http://movie.phinf.naver.net/20171201_181/1512109983114kcQVl_JPEG/movie_image.jpg",
 "user_rating": 7.98,
 "synopsis": "저승...."
 */

import UIKit

struct MovieInfoModel: Codable {
    
    var audience: Int = 0
    var title: String = ""
    var date: String = ""
    var reservationRate: Double = 0.0
    var reservationGrade: Int = 0
    var genre: String = ""
    var director: String = ""
    var id: String = ""
    var duration: Int = 0
    var grade: Int = 0
    var actor: String = ""
    var image: String = ""
    var userRating: Double = 0.0
    var synopsis: String = ""
    
    enum CodingKeys: String, CodingKey {
        case reservationRate = "reservation_rate"
        case reservationGrade = "reservation_grade"
        case audience = "audience"
        case title = "title"
        case date = "date"
        case genre = "genre"
        case director = "director"
        case id = "id"
        case duration = "duration"
        case actor = "actor"
        case image = "image"
        case userRating = "user_rating"
        case synopsis = "synopsis"
        case grade = "grade"
    }
    
}
