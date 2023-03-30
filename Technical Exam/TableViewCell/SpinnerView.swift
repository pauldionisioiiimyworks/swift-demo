//
//  SpinnerView.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import UIKit
import SnapKit

class SpinnerView: UIView {
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
        self.addSubview(spinner)
        
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        spinner.startAnimating()
        spinner.color = .white
    }
}
