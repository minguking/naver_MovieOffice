//
//  CommentTableViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/01.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

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
        
        addSubview(idLabel)
        addSubview(userImage)
        addSubview(dateLabel)
        addSubview(commentLabel)
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        userImage.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            userImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalToConstant: 80),
            
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),

            dateLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),

            commentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            commentLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 4),
            commentLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            commentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
        ])
        
        idLabel.font = .systemFont(ofSize: 16)
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .darkGray
        
    }
    
}
