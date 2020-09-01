//
//  FirstTableViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/30.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let titleLabel = UILabel()
    let pointLabel = UILabel()
    let bookingOrder = UILabel()
    let bookingRate = UILabel()
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Helper
    
    func configureUI() {
        
        addSubview(movieImage)
        addSubview(titleLabel)
        addSubview(pointLabel)
        addSubview(bookingOrder)
        addSubview(bookingRate)
        addSubview(releaseDate)
        addSubview(ageImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        bookingOrder.translatesAutoresizingMaskIntoConstraints = false
        bookingRate.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        ageImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            movieImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            movieImage.widthAnchor.constraint(equalToConstant: 100),
        
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 4),
            
            pointLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            pointLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 4),
            
            bookingOrder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            bookingOrder.leadingAnchor.constraint(equalTo: pointLabel.trailingAnchor, constant: 10),
            
            bookingRate.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            bookingRate.leadingAnchor.constraint(equalTo: bookingOrder.trailingAnchor, constant: 10),
            
            releaseDate.topAnchor.constraint(equalTo: pointLabel.bottomAnchor, constant: 12),
            releaseDate.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 4),
            
            ageImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            ageImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4)
            
        ])
        
        titleLabel.font = .systemFont(ofSize: 20)
        pointLabel.font = .systemFont(ofSize: 14)
        bookingOrder.font = .systemFont(ofSize: 14)
        bookingRate.font = .systemFont(ofSize: 14)
        releaseDate.font = .systemFont(ofSize: 14)
    }

}
