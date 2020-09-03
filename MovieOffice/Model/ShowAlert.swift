//
//  ShowAlert.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/31.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

let networkURL = NetworkURL()

func showAlert(navigation: UINavigationItem, navController: UINavigationController) {
    
    let alert = UIAlertController(title: "정렬방식 선택",
                                  message: "영화를 어떤 순서로 정렬할까요?",
                                  preferredStyle: .actionSheet)
    let orderRate = UIAlertAction(title: "예매율", style: .default) { action in
        SharedInfo.shared.orderType = 0
        navigation.title = "예매율순"
        requestMovie(first: networkURL.type, second: "\(SharedInfo.shared.orderType)")
    }
    let curation = UIAlertAction(title: "큐레이션", style: .default) { action in
        SharedInfo.shared.orderType = 1
        navigation.title = "큐레이션"
        requestMovie(first: networkURL.type, second: "\(SharedInfo.shared.orderType)")
    }
    let releaseDate = UIAlertAction(title: "개봉일", style: .default) { action in
        SharedInfo.shared.orderType = 2
        navigation.title = "개봉일순"
        requestMovie(first: networkURL.type, second: "\(SharedInfo.shared.orderType)")
    }
    let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
    
    alert.addAction(orderRate)
    alert.addAction(curation)
    alert.addAction(releaseDate)
    alert.addAction(cancel)
    
    navController.present(alert, animated: true, completion: nil)
    
   
    
}
