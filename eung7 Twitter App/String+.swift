//
//  String+.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/30.
//

import Foundation
import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
