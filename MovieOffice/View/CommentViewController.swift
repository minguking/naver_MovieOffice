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
    let starImage1: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_star_large_full")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let starImage2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_star_large_full")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let starImage3: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_star_large_full")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let starImage4: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_star_large_full")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let starImage5: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_star_large_full")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    
    let nickNameTf = UITextField()
    let contentTv = UITextView()
    
    let slider = UISlider()
    let ratingLabel = UILabel()
    
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
        
        if !nickNameTf.hasText || !contentTv.hasText {
            guard let nav = navigationController else { return }
            showWarning(navController: nav)
        } else {
            
            guard let url = URL(string: "https://connect-boxoffice.run.goorm.io/comment") else { return }
            
            //
            
            let param: [String: Any] = [
                "rating": Int(ratingLabel.text!),
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
    }
    
    @objc func handleSlider() {
        ratingLabel.text = "\(Int(slider.value))"
        
        var halfNum = Int(slider.value) / 2
        
        let stars = [starImage1, starImage2, starImage3, starImage4, starImage5]
        
        if Int(slider.value) % 2 == 0 {
            
            if Int(slider.value) == 10 {
                for i in 0...4 {
                    stars[i].image = UIImage(named: "ic_star_large_full")
                }
            } else {
                for i in 0..<Int(slider.value)/2 {
                    stars[i].image = UIImage(named: "ic_star_large_full")
                }
                for j in Int(slider.value)/2...4 {
                    stars[j].image = UIImage(named: "ic_star_large")
                }
            }
            
        } else {
            
            if Int(slider.value) == 9 {
                for i in 0..<Int(slider.value)/2 {
                    stars[i].image = UIImage(named: "ic_star_large_full")
                }
                stars[4].image = UIImage(named: "ic_star_large_half")
            } else {
                
                for i in 0..<Int(slider.value)/2 {
                    stars[i].image = UIImage(named: "ic_star_large_full")
                }
                stars[Int(slider.value/2)].image = UIImage(named: "ic_star_large_half")
                for j in Int(Int(slider.value)/2)+1...4 {
                    stars[j].image = UIImage(named: "ic_star_large")
                }
            }
        }
        
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        
        slider.maximumValue = 10
        slider.minimumValue = 1
        slider.value = 10
        slider.backgroundColor = .clear
        slider.tintColor = .clear
        slider.thumbTintColor = .clear
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        slider.maximumTrackTintColor = .clear
        
        
        topView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        topView.addSubview(ratingLabel)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navigationController?.navigationBar.barTintColor = .systemTeal
        
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        view.addSubview(topView)
        view.addSubview(bottomView)
        topView.addSubview(titleLabel)
        topView.addSubview(starImage1)
        topView.addSubview(starImage2)
        topView.addSubview(starImage3)
        topView.addSubview(starImage4)
        topView.addSubview(starImage5)
        view.addSubview(ageImage)
        bottomView.addSubview(nickNameTf)
        bottomView.addSubview(contentTv)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        starImage1.translatesAutoresizingMaskIntoConstraints = false
        starImage2.translatesAutoresizingMaskIntoConstraints = false
        starImage3.translatesAutoresizingMaskIntoConstraints = false
        starImage4.translatesAutoresizingMaskIntoConstraints = false
        starImage5.translatesAutoresizingMaskIntoConstraints = false
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
            
            starImage1.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starImage1.trailingAnchor.constraint(equalTo: starImage2.leadingAnchor, constant: -2),
            
            starImage2.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starImage2.trailingAnchor.constraint(equalTo: starImage3.leadingAnchor, constant: -2),
            
            starImage3.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starImage3.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            starImage4.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starImage4.leadingAnchor.constraint(equalTo: starImage3.trailingAnchor, constant: 2),
            
            starImage5.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            starImage5.leadingAnchor.constraint(equalTo: starImage4.trailingAnchor, constant: 2),
            
            slider.leadingAnchor.constraint(equalTo: starImage1.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: starImage5.trailingAnchor),
            slider.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            
            ratingLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            ratingLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20)
            
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
        
        ratingLabel.text = "\(Int(slider.value))"
        
        
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
