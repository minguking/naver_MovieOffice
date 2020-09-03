//
//  Request.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/30.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

let DidReceiveNotification = Notification.Name("didReceive")

func requestMovie(first: String, second: String) {
    
    let networkURL = NetworkURL()
    
    guard let url = URL(string: networkURL.baseURL + first + second) else { return }
    
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: url) { (data, response, error) in
        
        if let err = error {
            print(err.localizedDescription)
        }
        
        guard let data = data else { return }
        
        do {
            let movieModel = try JSONDecoder().decode(Model.self, from: data)
            
            NotificationCenter.default.post(name: DidReceiveNotification, object: nil, userInfo: ["movies": movieModel.movies])
            
        } catch(let err) {
            print(err)
        }
        
    }
    dataTask.resume()
}

