//
//  Photos.swift
//  Technical Exam
//
//  Created by Paul Dionisio on 10/31/22.
//

import Moya
import HandyJSON

class Photos: NSObject, Codable, HandyJSON {
    var albumId: String?
    var id: String?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    override required init() {}
}
