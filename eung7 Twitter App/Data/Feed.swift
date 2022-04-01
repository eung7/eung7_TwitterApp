//
//  Feed.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import Foundation

struct Feed : Codable {
    var contents : String
    var isHeart : Bool
    
    static var shared = Feed(contents: "Default", isHeart: false)
}
