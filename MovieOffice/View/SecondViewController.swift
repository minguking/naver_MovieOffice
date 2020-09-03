//
//  CollectionViewController.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/30.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SecondViewController: UIViewController {
    
    // MARK: - Properties
    
    var movieModel = [MovieModel]()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(handleSort))
        return button
    }()
    
    let refreshControl = UIRefreshControl()

    // collectionView
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        switch SharedInfo.shared.orderType {
        case 1:
            navigationItem.title = "큐레이션"
        case 2:
            navigationItem.title = "개봉일순"
        default:
            navigationItem.title = "예매율순"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureUI()
        
        requestMovie(first: networkURL.type, second: "\(SharedInfo.shared.orderType)")
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNoti(_:)), name: DidReceiveNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationItem.title = "영화목록"
    }
    
    
    // MARK: - Selector
    
    @objc func didReceiveNoti(_ noti: Notification) {
        
        guard let movieModel = noti.userInfo?["movies"] as? [MovieModel] else { return }
        
        self.movieModel = movieModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc func handleSort() {
        guard let nav = navigationController else { return }
        showAlert(navigation: navigationItem, navController: nav)
        
    }
    
    @objc func refresh() {
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        
        collectionView.backgroundColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
        
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        //collectionView Layout
        view.addSubview(collectionView)
        collectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SecondCollectionViewCell
        
        let movie = movieModel[indexPath.item]
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: movie.thumb) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
//                cell.backgroundColor = .systemPink
                cell.movieImage.image = UIImage(data: imageData)
                cell.titleLabel.text = movie.title
                cell.titleLabel.adjustsFontSizeToFitWidth = true
                cell.infoLabel.text = "\(movie.reservationGreade)위(\(movie.userRating)) / \(movie.reservationRate)%"
                cell.releaseDate.text = movie.date
                cell.ageImage.image = UIImage(named: "ic_\(movie.grade)")
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: view.frame.size.width / 4 - 40, height: 360)
        } else {
            return CGSize(width: view.frame.size.width / 2 - 20, height: 360)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = MovieDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        SharedInfo.shared.movieId = movieModel[indexPath.row].id
        SharedInfo.shared.movieThumbnail = movieModel[indexPath.row].thumb
        SharedInfo.shared.movieTitle = movieModel[indexPath.row].title
    }
    
}
