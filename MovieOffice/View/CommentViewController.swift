//
//  CommentViewController.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/09/01.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    // MARK: - Properties
    
    let postModel = [PostModel]()
    let networkURL = NetworkURL()
    
    lazy var leftButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(handleCancel))
    lazy var rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(handleDone))
    
    let topView = UIView()
    let bottomView = UIView()
    let titleLabel = UILabel()
    let ageImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    let starImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_star_large_full")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    let nickNameTf = UITextField()
    let contentTv = UITextView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "한줄평 작성"
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        configureUI()
        placeHolderSetting()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        let vc = MovieDetailViewController()
        vc.tableView.reloadData()
    }
    
    
    // MARK: - Selector
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
        let vc = MovieDetailViewController()
        vc.tableView.reloadData()
    }
    
    @objc func handleDone() {
        
        guard let url = URL(string: "https://connect-boxoffice.run.goorm.io/comment") else { return }

        //
        
        let param: [String: Any] = [
            "rating": 2.0,
            "writer": nickNameTf.text,
            "movie_id": SharedInfo.shared.movieId,
            "contents": contentTv.text
        ]

        let paramData = try! JSONSerialization.data(withJSONObject: param, options: [])

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = paramData

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                print("God damn error!!! \(err.localizedDescription)")
                return
            }
        }
        dataTask.resume()
        
        SharedInfo.shared.nickName = nickNameTf.text
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        
        navigationController?.navigationBar.barTintColor = .systemTeal
        
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        view.addSubview(topView)
        view.addSubview(bottomView)
        topView.addSubview(titleLabel)
        topView.addSubview(starImage)
        view.addSubview(ageImage)
        bottomView.addSubview(nickNameTf)
        bottomView.addSubview(contentTv)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        starImage.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        ageImage.translatesAutoresizingMaskIntoConstraints = false
        nickNameTf.translatesAutoresizingMaskIntoConstraints = false
        contentTv.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // topView height를 가로모드를 고려해서 view height의 0.3배로 정함
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            
            ageImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            ageImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            
            nickNameTf.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            nickNameTf.leadingAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            nickNameTf.heightAnchor.constraint(equalToConstant: 32),
            nickNameTf.trailingAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            contentTv.topAnchor.constraint(equalTo: nickNameTf.bottomAnchor, constant: 12),
            contentTv.leadingAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            contentTv.bottomAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            contentTv.trailingAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            
            starImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor)
            
        ])
        
        topView.backgroundColor = .white
        bottomView.backgroundColor = .white
        titleLabel.text = SharedInfo.shared.movieTitle
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)
        guard let image = SharedInfo.shared.ageImage else { return }
        ageImage.image = UIImage(named: "ic_\(image)")
        
        nickNameTf.borderStyle = .roundedRect
        nickNameTf.placeholder = "닉네임을 입력하세요"
        nickNameTf.text = SharedInfo.shared.nickName ?? nil
        
        contentTv.layer.borderWidth = 1
        contentTv.layer.borderColor = UIColor.systemPink.cgColor
        contentTv.font = .systemFont(ofSize: 17)
        
        
    }
    
    func placeHolderSetting() {
        contentTv.delegate = self
        contentTv.text = "한줄평을 작성해주세요"
        contentTv.textColor = .lightGray
    }
    
}

extension CommentViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "한줄평을 작성해주세요"
            textView.textColor = .lightGray
        }
    }
    
}
