//
//  PhotosTableViewCell.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import UIKit
import SnapKit
import Kingfisher

class PhotosTableViewCell: UITableViewCell {
    
    lazy var thumbNail: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBlue
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var id: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18.0)!
        label.numberOfLines = 1
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 18.0)!
        label.numberOfLines = 3
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var photo: Photos!
    var delegate: TableViewCellToViewControllerProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeUI()
    }
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializeUI()
    }
    
    func initializeUI() {
        self.addSubview(thumbNail)
        self.addSubview(id)
        self.addSubview(title)
        self.isUserInteractionEnabled = true
        
        thumbNail.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }
        
        id.snp.makeConstraints {
            $0.top.equalTo(thumbNail.snp.top)
            $0.leading.equalTo(title.snp.leading)
            $0.trailing.equalTo(title.snp.trailing)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(thumbNail.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalTo(id.snp.bottom).offset(10)
        }
        
        self.selectionStyle = .none
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showPhotoDetails))
        self.addGestureRecognizer(tapGesture)
    }
    
    func setup(photo: Photos) {
        
        self.photo = photo
        self.id.text = self.photo.id
        self.title.text = self.photo.title
        
        guard let thumbNailUrl = self.photo.thumbnailUrl else {
            return
        }
        let url = URL(string: thumbNailUrl)
        thumbNail.kf.setImage(with: url)
    }
    
    @objc func showPhotoDetails(_ sender: UITapGestureRecognizer) {
        guard let photo = photo else {
            return
        }
        delegate.showPhotoDetails(photo: photo)
    }
}
