//
//  ViewController.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import UIKit
import Moya
import SnapKit

protocol ViewModelToViewControllerProtocol {
    func reloadPhotos(photos: [Photos?])
}

protocol TableViewCellToViewControllerProtocol {
    func showPhotoDetails(photo: Photos)
}

class HomeViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = UIFont(name: "HelveticaNeue", size: 42.0)!
        label.sizeToFit()
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var spinner: SpinnerView = {
        let view = SpinnerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel = PostsViewModel()
    var photos: [Photos?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(spinner)
        self.view.addSubview(titleLabel)
        self.view.addSubview(tableView)
        viewModel.delegate = self
        viewModel.fetchPosts()
        
        var navBarHeight = 0.0
        if let navigationController = self.navigationController {
            navBarHeight = navigationController.navigationBar.frame.size.height + 20
        }
        
        spinner.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(navBarHeight)
            $0.trailing.equalToSuperview().offset(-20)
        }

        tableView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.rowHeight = 120
        
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        self.view.bringSubviewToFront(spinner)
    }
}

extension HomeViewController: ViewModelToViewControllerProtocol {
    func reloadPhotos(photos: [Photos?]) {
        self.photos = photos
        tableView.reloadData()
        self.spinner.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
        self.titleLabel.isHidden = false
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell") as? PhotosTableViewCell {
            
            guard let photo = photos[indexPath.row] else {
                return PhotosTableViewCell()
            }
            
            cell.delegate = self
            cell.setup(photo: photo)
            return cell
        }
        
        return PhotosTableViewCell()
    }
}

extension HomeViewController: TableViewCellToViewControllerProtocol {
    func showPhotoDetails(photo: Photos) {
        let photoViewController = PhotosViewController()
        photoViewController.photo = photo
        self.navigationController?.pushViewController(photoViewController, animated: true)
    }
}
