//
//  UserDefaultsManager.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/30.
//

import Foundation


struct UserDefaultsManager {
    
    static func saveFeed(feed : Feed) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(feed) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "Feeds")
        }
    }
    
    static func loadFeed() -> [Feed] {
        let decoder = JSONDecoder()
        let savedData = UserDefaults.standard.data(forKey: "Feeds")
        guard let feeds = try? decoder.decode([Feed].self, from: savedData ?? Data()) else { return [] }
        
        return feeds
    }
    
    static func loadUserInfo() -> UserInfo {
        let decoder = JSONDecoder()
        let savedData = UserDefaults.standard.data(forKey: "UserInfo")
        guard let userInfo = try? decoder.decode(UserInfo.self, from: savedData ?? Data()) else {
            return UserInfo(username: "Default", account: "Default")
        }
        
        return userInfo
    }
    
    static func saveUserInfo(userInfo : UserInfo) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(userInfo) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "UserInfo")
        }
    }
}
