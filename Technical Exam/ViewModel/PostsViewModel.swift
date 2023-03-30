//
//  PostsViewModel.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import RxSwift
import Moya

protocol PostsViewModelType: NSObject {
    func fetchPosts()
}

class PostsViewModel: NSObject, PostsViewModelType {
    
    var delegate: ViewModelToViewControllerProtocol!
    let provider = MoyaProvider<Service>()
    let disposeBag = DisposeBag()
    
    func fetchPosts() {
        provider.rx.request(.getPosts).subscribe { event in
            switch event {
            case .success(let response):
                let json = String(data:response.data, encoding: .utf8)
                if let object = [Photos].deserialize(from: json) {
                    for photo in object {
                        photo?.title = photo?.title?.capitalized
                    }
                    self.delegate.reloadPhotos(photos: object)
                }
                break
            case .failure(let error):
                print("error \(error)")
                break
            }
        }.disposed(by: disposeBag)
    }
}
