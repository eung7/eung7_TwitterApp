//
//  Feed.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import Foundation

struct Feed : Codable {
    let contents : String
    var isHeart : Bool
    
    static var currentFeeds : [Feed] {
        get {
            let decoder = JSONDecoder()
            let savedData = UserDefaults.standard.data(forKey: "Feeds")
            let feed = try? decoder.decode([Feed].self, from: savedData ?? Data())
            
            return feed ?? []
        }
        set {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(data, forKey: "Feeds")
            }
        }
    }
}
