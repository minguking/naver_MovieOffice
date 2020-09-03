//
//  DetailCollectionViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/31.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

let cellId = "cell"

class DetailTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let topView = UIView()
    
    let movieImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let ageImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let titleLabel = UILabel()
    let releaseDate = UILabel()
    let genreAndDuration = UILabel()
    
    var stackView = UIStackView()
    
    let leftView = UIView()
    let middleView = UIView()
    let rightView = UIView()
    
    let bookingRateLabel = UILabel()
    let gradeAndBookingRate = UILabel()
    
    let pointLabel = UILabel()
    let point = UILabel()
    
    let audienceLabel = UILabel()
    let audience = UILabel()
    
    let background = UIView()
    let flowLayout = UICollectionViewFlowLayout()
    
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: detailCellId)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        let collectionView = UICollectionView(frame: .zero,
        collectionViewLayout: flowLayout)
        
        collectionView.register(StarCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        flowLayout.scrollDirection = .horizontal
        collectionView.isScrollEnabled = false
        
        collectionView.backgroundColor = .clear
        
        stackView = UIStackView(arrangedSubviews: [leftView, middleView, rightView])
        stackView.insertSubview(background, at: 0)
        
        topView.backgroundColor = .clear
        
        addSubview(topView)
        addSubview(stackView)
        topView.addSubview(movieImage)
        addSubview(titleLabel)
        addSubview(ageImage)
        addSubview(releaseDate)
        addSubview(genreAndDuration)
        
        leftView.addSubview(bookingRateLabel)
        leftView.addSubview(gradeAndBookingRate)
        middleView.addSubview(pointLabel)
        middleView.addSubview(point)
        middleView.addSubview(collectionView)
        rightView.addSubview(audienceLabel)
        rightView.addSubview(audience)
        
        // info view
        topView.translatesAutoresizingMaskIntoConstraints = false
        gradeAndBookingRate.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ageImage.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        genreAndDuration.translatesAutoresizingMaskIntoConstraints = false
        bookingRateLabel.translatesAutoresizingMaskIntoConstraints = false
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        audienceLabel.translatesAutoresizingMaskIntoConstraints = false
        point.translatesAutoresizingMaskIntoConstraints = false
        audienceLabel.translatesAutoresizingMaskIntoConstraints = false
        audience.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        
        //layout
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 160),
            topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            movieImage.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 8),
            movieImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            
            ageImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            ageImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
            
            releaseDate.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDate.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            
            genreAndDuration.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 8),
            genreAndDuration.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            
            // stack view
            background.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
            background.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            background.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -16),
            background.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            bookingRateLabel.topAnchor.constraint(equalTo: leftView.topAnchor, constant: 20),
            bookingRateLabel.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            
            gradeAndBookingRate.topAnchor.constraint(equalTo: bookingRateLabel.bottomAnchor, constant: 10),
            gradeAndBookingRate.centerXAnchor.constraint(equalTo: leftView.centerXAnchor),
            
            pointLabel.topAnchor.constraint(equalTo: middleView.topAnchor, constant: 12),
            pointLabel.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
            
            point.topAnchor.constraint(equalTo: pointLabel.bottomAnchor, constant: 10),
            point.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
            
            
            collectionView.centerXAnchor.constraint(equalTo: middleView.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: point.bottomAnchor, constant: 4),
            collectionView.heightAnchor.constraint(equalToConstant: 30),
            collectionView.widthAnchor.constraint(equalToConstant: 104),
            
            
            audienceLabel.topAnchor.constraint(equalTo: rightView.topAnchor, constant: 20),
            audienceLabel.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            
            audience.topAnchor.constraint(equalTo: audienceLabel.bottomAnchor, constant: 10),
            audience.centerXAnchor.constraint(equalTo: rightView.centerXAnchor),
            
            
        ])
        
        titleLabel.font = .systemFont(ofSize: 24)
        
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 1
        
        bookingRateLabel.textAlignment = .center
        bookingRateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        leftView.backgroundColor = .white
        middleView.backgroundColor = .white
        rightView.backgroundColor = .white
        background.backgroundColor = .lightGray
        
        pointLabel.textAlignment = .center
        pointLabel.font = .systemFont(ofSize: 18, weight: .medium)
        
        audienceLabel.font = .systemFont(ofSize: 18, weight: .medium)
    }
}


extension DetailTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StarCollectionViewCell
        
        let stringNum = SharedInfo.shared.point!
        let num = Int(stringNum)
        
        let halfNum: Double = Double(num) / 2
        
        if num % 2 == 0 {

            if indexPath.row < Int(halfNum) {
                cell.starImage.image = UIImage(named: "ic_star_full")
            } else {
                cell.starImage.image = UIImage(named: "ic_star_empty")
            }

        } else {
            if indexPath.row < Int(halfNum) {
                cell.starImage.image = UIImage(named: "ic_star_full")
            } else if indexPath.row == Int(halfNum) {
                cell.starImage.image = UIImage(named: "ic_star_half")
            } else {
                cell.starImage.image = UIImage(named: "ic_star_empty")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 20, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
