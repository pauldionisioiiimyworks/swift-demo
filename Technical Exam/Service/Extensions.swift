//
//  Extensions.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import Moya

enum Service {
    case getPosts
}

extension Service: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .getPosts:
            return "/photos"
        }
    }
    
    var method: Method {
        switch self {
        case .getPosts:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
