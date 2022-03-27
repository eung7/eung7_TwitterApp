//
//  Entitiy.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import Foundation

struct UserInfo : Codable {
    let username : String
    let account : String
    
    static var currentUserInfo : UserInfo {
        get {
            let decoder = JSONDecoder()
            let savedData = UserDefaults.standard.data(forKey: "UserInfo")
            let userInfo = try? decoder.decode(UserInfo.self, from: savedData ?? Data())
            
            return userInfo ?? UserInfo(username: "Default", account: "Default")
        }
        set {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(data, forKey: "UserInfo")
            }
        }
    }
}
