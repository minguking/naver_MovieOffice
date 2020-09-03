//
//  SharedInfo.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/31.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class SharedInfo {
    
    static let shared = SharedInfo()
    
    var orderType: Int = 0
    var movieId: String?
    var movieThumbnail: String?
    var movieTitle: String?
    var ageImage: Int?
    var nickName: String?
    var point: Double?
}
