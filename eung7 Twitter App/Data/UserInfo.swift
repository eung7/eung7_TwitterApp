//
//  Entitiy.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import Foundation
import UIKit

struct UserInfo : Codable {
    let username : String
    let account : String
    
    static var shared : UserInfo = UserInfo(username: "Default", account: "Default")
}

