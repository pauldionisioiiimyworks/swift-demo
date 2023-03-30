//
//  PhotoView.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import UIKit
import Kingfisher

class PhotoView: UIView {
        
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 42.0)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 24.0)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var spinner: SpinnerView = {
        let view = SpinnerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeUI()
    }

    func initializeUI() {
        self.addSubview(idLabel)
        self.addSubview(titleLabel)
        self.addSubview(photoImageView)
        self.addSubview(spinner)
        
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 1
        
        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(photoImageView.snp.leading)
            $0.trailing.equalTo(photoImageView.snp.trailing)
        }
        
        spinner.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(100)
            $0.center.equalTo(photoImageView.snp.center)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(20)
            $0.leading.equalTo(photoImageView.snp.leading)
            $0.trailing.equalTo(photoImageView.snp.trailing)
        }
        
        photoImageView.snp.makeConstraints {
            $0.height.equalTo(300)
            $0.width.equalTo(300)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
    
    func hideSpinnerView() {
        self.spinner.spinner.stopAnimating()
        self.spinner.removeFromSuperview()
    }
}
