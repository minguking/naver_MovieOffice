//
//  CommentTableViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/01.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

private let rateCellId = "rate"

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let userImage: UIImageView = {
        let img = UIImageView(image: UIImage(named: "ic_user_loading"))
        img.contentMode = .scaleToFill
        return img
    }()
    let idLabel = UILabel()
    let dateLabel = UILabel()
    let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let layout = UICollectionViewFlowLayout()
    
    var point: Double = 0.0
    
    var starImage1 = UIImageView()
    var starImage2 = UIImageView()
    var starImage3 = UIImageView()
    var starImage4 = UIImageView()
    var starImage5 = UIImageView()
    
    
    // MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(RateCollectionViewCell.self, forCellWithReuseIdentifier: rateCellId)
//        collectionView.backgroundColor = .clear
//        layout.scrollDirection = .horizontal
//        collectionView.isScrollEnabled = false
        
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        
//        addSubview(collectionView)
        
        addSubview(idLabel)
        addSubview(userImage)
        addSubview(dateLabel)
        addSubview(commentLabel)
        addSubview(starImage1)
        addSubview(starImage2)
        addSubview(starImage3)
        addSubview(starImage4)
        addSubview(starImage5)
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
        starImage1.translatesAutoresizingMaskIntoConstraints = false
        starImage2.translatesAutoresizingMaskIntoConstraints = false
        starImage3.translatesAutoresizingMaskIntoConstraints = false
        starImage4.translatesAutoresizingMaskIntoConstraints = false
        starImage5.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalToConstant: 80),
            
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),
            
//            collectionView.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 4),
//            collectionView.widthAnchor.constraint(equalToConstant: 104),
//            collectionView.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),
            
            commentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            commentLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            starImage1.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            starImage1.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 4),
            
            starImage2.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            starImage2.leadingAnchor.constraint(equalTo: starImage1.trailingAnchor, constant: 2),
            
            starImage3.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            starImage3.leadingAnchor.constraint(equalTo: starImage2.trailingAnchor, constant: 2),
            
            starImage4.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            starImage4.leadingAnchor.constraint(equalTo: starImage3.trailingAnchor, constant: 2),
            
            starImage5.centerYAnchor.constraint(equalTo: idLabel.centerYAnchor),
            starImage5.leadingAnchor.constraint(equalTo: starImage4.trailingAnchor, constant: 2),
        ])
        
        idLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .darkGray
        
    }
    
}


//extension CommentTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: rateCellId, for: indexPath) as! RateCollectionViewCell
//        
//        let num = Int(point)
//        
//        let halfNum: Double = Double(num) / 2
//        
//        if num % 2 == 0 {
//            
//            if indexPath.row < Int(halfNum) {
//                cell.starImage.image = UIImage(named: "ic_star_full")
//            } else {
//                cell.starImage.image = UIImage(named: "ic_star_empty")
//            }
//            
//        } else {
//            
//            if indexPath.row < Int(halfNum) {
//                cell.starImage.image = UIImage(named: "ic_star_full")
//            } else if indexPath.row == Int(halfNum) {
//                cell.starImage.image = UIImage(named: "ic_star_half")
//            } else {
//                cell.starImage.image = UIImage(named: "ic_star_empty")
//            }
//        }
//        return cell
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 20, height: 20)
//    }
//    
//    
//    
//}
