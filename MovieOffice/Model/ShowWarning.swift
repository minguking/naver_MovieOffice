//
//  ShowWarning.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/05.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

func showWarning(navController: UINavigationController) {
    
    let warning = UIAlertController(title: "경고", message: "닉네임과 한줄평 모두 작성해주세요.", preferredStyle: .alert)
    
    let okayButton = UIAlertAction(title: "확인", style: .default, handler: nil)
    
    warning.addAction(okayButton)
    
    navController.present(warning, animated: true, completion: nil)
}
