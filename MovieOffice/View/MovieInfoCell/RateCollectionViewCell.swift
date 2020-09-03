//
//  RateCollectionViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/03.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class RateCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let starImage = UIImageView()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(starImage)
        
        starImage.translatesAutoresizingMaskIntoConstraints = false
        
        starImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        starImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
