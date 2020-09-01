//
//  SecondCollectionViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/30.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    let releaseDate = UILabel()
    
    let movieImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let ageImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        
        addSubview(movieImage)
        addSubview(titleLabel)
        addSubview(infoLabel)
        addSubview(releaseDate)
        movieImage.addSubview(ageImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        ageImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 280),
        
            titleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            releaseDate.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 8),
            releaseDate.leadingAnchor.constraint(equalTo: leadingAnchor),
            releaseDate.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            ageImage.topAnchor.constraint(equalTo: movieImage.topAnchor, constant: 18),
            ageImage.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -8),
            ageImage.heightAnchor.constraint(equalToConstant: 30),
            ageImage.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 24)
        
        infoLabel.textAlignment = .center
        infoLabel.font = .systemFont(ofSize: 16)
        
        releaseDate.textAlignment = .center
        releaseDate.font = .systemFont(ofSize: 14)
    }
}
