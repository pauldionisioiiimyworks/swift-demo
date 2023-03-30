//
//  NetworkManager.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import RxSwift
import Moya

struct NetworkManager {
    
    static let shared = NetworkManager()
    private let provider = MoyaProvider<Service>()
    
    private init() {}
    
    func getPosts() -> Single<[Photos]> {
        return provider.rx
            .request(.getPosts)
            .filterSuccessfulStatusAndRedirectCodes()
            .map([Photos].self)
    }
}
