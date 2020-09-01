//
//  ImageViewController.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/01.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("닫기", for: .normal)
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(image)
        view.addSubview(closeButton)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            image.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            image.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
        ])
        
        closeButton.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    
    // MARK: - Selector
    
    @objc func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
}
