//
//  ViewController.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/30.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

private let reusableCell = "cell"

class FirstViewController: UIViewController {
    
    // MARK: - Properties
    
    var orderType = 0
    let type = "movies?order_type="
    let networkURL = NetworkURL()
    
    lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(handleSort))
        return button
    }()
    
    let refreshControl = UIRefreshControl()
    var movieModel = [MovieModel]()
    
    // tableView
    let tableView = UITableView()
    
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureUI()
        requestMovie(first: SharedInfo.shared.type, second: "\(networkURL.type)")
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNoti(_:)),
                                               name: DidReceiveNotification,
                                               object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        navigationItem.title = "영화목록"
    }
    
    
    // MARK: - Selector
    
    @objc func handleSort() {
        guard let nav = navigationController else { return }
        showAlert(navigation: navigationItem, navController: nav)
    }
    
    @objc func refresh() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc func didReceiveNoti(_ noti: Notification) {
        
        guard let movieModel = noti.userInfo?["movies"] as? [MovieModel] else { return }
        
        self.movieModel = movieModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        
        navigationItem.rightBarButtonItem = rightBarButton
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        // TableView Layout
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FirstTableViewCell.self, forCellReuseIdentifier: reusableCell)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}


extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCell, for: indexPath) as! FirstTableViewCell
        
        let movie = movieModel[indexPath.row]
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: movie.thumb) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                cell.movieImage.image = UIImage(data: imageData)
                cell.titleLabel.text = movie.title
                cell.pointLabel.text = "평점 : \(movie.userRating)"
                cell.bookingOrder.text = "예매순위 : \(movie.reservationGreade)"
                cell.bookingRate.text = "예매율 : \(movie.reservationRate)"
                cell.releaseDate.text = "개봉일 : \(movie.date)"
                cell.ageImage.image = UIImage(named: "ic_\(movie.grade)")
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = MovieDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        SharedInfo.shared.movieId = movieModel[indexPath.row].id
        SharedInfo.shared.movieThumbnail = movieModel[indexPath.row].thumb
        SharedInfo.shared.movieTitle = movieModel[indexPath.row].title
        SharedInfo.shared.ageImage = movieModel[indexPath.row].grade
        
    }
    
    
    
}
