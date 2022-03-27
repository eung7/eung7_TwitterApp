//
//  Feed.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import Foundation

struct Feed : Codable {
    let contents : String
    let isHeart : Bool
    
    static var currentFeed : [Feed] {
        get {
            let decoder = JSONDecoder()
            let savedData = UserDefaults.standard.data(forKey: "Feed")
            let feed = try? decoder.decode([Feed].self, from: savedData ?? Data())
            
            return feed ?? []
        }
        set {
            
        }
    }
}
