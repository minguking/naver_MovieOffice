//
//  AnotherTableViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/01.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class StaffTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let directorAndActor = UILabel()
    let directorLabel = UILabel()
    let director = UILabel()
    let actorLabel = UILabel()
    let actor = UILabel()
    
    
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
        
        addSubview(directorAndActor)
        addSubview(directorLabel)
        addSubview(director)
        addSubview(actorLabel)
        addSubview(actor)
        
        directorAndActor.translatesAutoresizingMaskIntoConstraints = false
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        director.translatesAutoresizingMaskIntoConstraints = false
        actorLabel.translatesAutoresizingMaskIntoConstraints = false
        actor.translatesAutoresizingMaskIntoConstraints = false
        
        // layout
        NSLayoutConstraint.activate([
            directorAndActor.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            directorAndActor.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            //
            directorLabel.topAnchor.constraint(equalTo: directorAndActor.bottomAnchor, constant: 20),
            directorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            actorLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 12),
            actorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            director.centerYAnchor.constraint(equalTo: directorLabel.centerYAnchor),
            director.leadingAnchor.constraint(equalTo: directorLabel.trailingAnchor, constant: 8),
            
            actor.centerYAnchor.constraint(equalTo: actorLabel.centerYAnchor),
            actor.leadingAnchor.constraint(equalTo: actorLabel.trailingAnchor, constant: 8),
            actor.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            actor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            
        ])
        
        // detail
        directorAndActor.font = .systemFont(ofSize: 22)
        directorLabel.font = .systemFont(ofSize: 18, weight: .medium)
        actorLabel.font = .systemFont(ofSize: 18, weight: .medium)
        actor.numberOfLines = 0
    }

}
