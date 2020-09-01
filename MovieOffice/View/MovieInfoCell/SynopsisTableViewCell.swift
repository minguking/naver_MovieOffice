//
//  SynopsisTableViewCell.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/01.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let synopsisLabel = UILabel()
    let synopsis = UILabel()
    
    
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
        
        addSubview(synopsisLabel)
        addSubview(synopsis)
        
        synopsisLabel.translatesAutoresizingMaskIntoConstraints = false
        synopsis.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            synopsisLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            synopsisLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            synopsis.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 10),
            synopsis.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            synopsis.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            synopsis.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        
        synopsisLabel.font = .systemFont(ofSize: 22)
        synopsis.numberOfLines = 0
    }
    
}
