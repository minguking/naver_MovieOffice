//
//  MovieDetailViewController.swift
//  MovieOffice
//
//  Created by Kang Mingu on 2020/08/31.
//  Copyright © 2020 Kang Mingu. All rights reserved.
//

import UIKit

let detailCellId = "cell"
let synopsisCellId = "synopsis"
let staffCellId = "staff"
let commentCellId = "comment"

class MovieDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    let tableView = UITableView()
    
    let networkURL = NetworkURL()
    var movieInfo = MovieInfoModel()
    var comments = [Comments]()
    
    let sectionHeader: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄평"
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    
    lazy var writeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btn_compose"), for: .normal)
        button.addTarget(self, action: #selector(handleWrite), for: .touchUpInside)
        return button
    }()
    
    let headerLine: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        view.frame.size = CGSize(width: view.frame.width, height: 4)
        return view
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        requestMovieInfo()
        requestComments()
    }
    
    
    // MARK: - Selectors
    
    @objc func handleWrite() {
        
        let nav = UINavigationController(rootViewController: CommentViewController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    @objc func handleImage() {
        let vc = ImageViewController()
        let image = movieInfo.image
        DispatchQueue.global().async {
            guard let imageURL = URL(string: image) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                vc.image.image = UIImage(data: imageData)
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Helper

    func configureUI() {
        
        navigationItem.title = SharedInfo.shared.movieTitle
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: detailCellId)
        tableView.register(StaffTableViewCell.self, forCellReuseIdentifier: staffCellId)
        tableView.register(SynopsisTableViewCell.self, forCellReuseIdentifier: synopsisCellId)
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: commentCellId)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        sectionHeader.addSubview(commentLabel)
        sectionHeader.addSubview(writeButton)
        sectionHeader.addSubview(headerLine)
        
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        writeButton.translatesAutoresizingMaskIntoConstraints = false
        headerLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            commentLabel.topAnchor.constraint(equalTo: headerLine.bottomAnchor, constant: 8),
            commentLabel.leadingAnchor.constraint(equalTo: sectionHeader.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            writeButton.topAnchor.constraint(equalTo: headerLine.bottomAnchor, constant: 8),
            writeButton.trailingAnchor.constraint(equalTo: sectionHeader.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            headerLine.topAnchor.constraint(equalTo: sectionHeader.topAnchor),
            headerLine.heightAnchor.constraint(equalToConstant: 4),
            headerLine.leadingAnchor.constraint(equalTo: sectionHeader.leadingAnchor),
            headerLine.trailingAnchor.constraint(equalTo: sectionHeader.trailingAnchor)
            
            
        ])
    }
    
    func requestMovieInfo() {
        
        guard let movieId = SharedInfo.shared.movieId else { return }
        guard let url = URL(string: networkURL.baseURL + networkURL.info + movieId) else
        { return }
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let info = try JSONDecoder().decode(MovieInfoModel.self, from: data)
                self.movieInfo = info
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func requestComments() {
        
        guard let movieId = SharedInfo.shared.movieId else { return }
        guard let url = URL(string: networkURL.baseURL + SharedInfo.shared.commentURL + movieId) else { return }
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let comment: CommentModel = try JSONDecoder().decode(CommentModel.self, from: data)
                self.comments = comment.comments
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch(let err) {
                print(err.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 3 {
            return comments.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: detailCellId, for: indexPath) as! DetailTableViewCell
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleImage))
            
            cell.movieImage.isUserInteractionEnabled = true
            cell.movieImage.tag = indexPath.row
            cell.movieImage.addGestureRecognizer(tapGesture)
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            let audience = numberFormatter.string(from: NSNumber(value: movieInfo.audience))
            
                DispatchQueue.global().async {
                    guard let image = SharedInfo.shared.movieThumbnail else { return }
                    guard let imageURL = URL(string: image) else { return }
                    guard let imageData = try? Data(contentsOf: imageURL) else { return }
                    
                    DispatchQueue.main.async {
                        
                        cell.movieImage.image = UIImage(data: imageData)
                        cell.titleLabel.text = self.movieInfo.title
                        cell.ageImage.image = UIImage(named: "ic_\(self.movieInfo.grade)")
                        cell.releaseDate.text = "\(self.movieInfo.date)개봉"
                        cell.genreAndDuration.text = "\(self.movieInfo.genre)/\(self.movieInfo.duration)분"
                        cell.bookingRateLabel.text = "예매율"
                        cell.gradeAndBookingRate.text = "\(self.movieInfo.reservationGrade)위 \(self.movieInfo.reservationRate)%"
                        cell.pointLabel.text = "평점"
                        cell.point.text = "\(self.movieInfo.userRating)"
                        cell.audienceLabel.text = "누적관객수"
                        cell.audience.text = audience
                    }
                }
            return cell
            
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: synopsisCellId, for: indexPath) as! SynopsisTableViewCell
            
            let attrString = NSMutableAttributedString(string: movieInfo.synopsis)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                    value: paragraphStyle,
                                    range: NSMakeRange(0, attrString.length))
            cell.synopsis.attributedText = attrString
            
            cell.synopsisLabel.text = "줄거리"
            cell.synopsis.text = movieInfo.synopsis
            
            return cell
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: staffCellId, for: indexPath) as! StaffTableViewCell

            cell.directorAndActor.text = "감독/출연"
            cell.directorLabel.text = "감독"
            cell.actorLabel.text = "배우"
            cell.director.text = movieInfo.director
            cell.actor.text = movieInfo.actor
            
            return cell
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: commentCellId, for: indexPath) as! CommentTableViewCell
            
            let date = NSDate(timeIntervalSince1970: comments[indexPath.row].timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let commentDate = dateFormatter.string(from: date as Date)
            
            cell.idLabel.text = comments[indexPath.row].writer
            cell.dateLabel.text = commentDate
            cell.commentLabel.text = comments[indexPath.row].contents
            
            return cell
            
        default: return UITableViewCell()
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return 1000
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 260
        }
        
        return tableView.estimatedRowHeight
    }
    
    // Section header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        } else if section == 3 {
            return 60
        }
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 3 {
            return sectionHeader
        }
        return nil
    }
    
}
