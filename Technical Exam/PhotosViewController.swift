//
//  PhotosViewController.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import UIKit
import SnapKit
import Kingfisher

class PhotosViewController: UIViewController {

    var photo: Photos!
    
    lazy var photoView: PhotoView = {
        let view = PhotoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        initializeUI()
    }
    
    func initializeUI() {
        
        self.view.addSubview(photoView)
        
        photoView.snp.makeConstraints {
            $0.height.equalTo(600)
            $0.width.equalTo(380)
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        photoView.idLabel.text = photo.id
        photoView.titleLabel.text = photo.title
        
        guard let photoUrl = photo.url else {
            return
        }
        
        let url = URL(string: photoUrl)
        
        let processor = DownsamplingImageProcessor(size: CGSize(width: 300, height: 300))
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        photoView.photoImageView.kf.indicatorType = .activity
        photoView.photoImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
                self.photoView.hideSpinnerView()
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
                self.photoView.photoImageView.backgroundColor = .systemBlue
                self.photoView.hideSpinnerView()
            }
        }
        
    }
    
}
