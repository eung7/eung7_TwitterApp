//
//  FeedTableViewCell.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/21.
//

import UIKit
import SnapKit

class FeedTableViewCell : UITableViewCell {
    
    let usernameLabel = UILabel()
    let accountLabel = UILabel()
    let contentsLabel = UILabel()
    let profileImageView = UIImageView()
    
    let heartIcon = UIImageView(image: UIImage(systemName: "heart"))
    let messageIcon = UIImageView(image: UIImage(systemName: "message"))
    let shareIcon = UIImageView(image: UIImage(systemName: "square.and.arrow.up"))
    
    private func setupLayout() {
        [ usernameLabel, accountLabel, contentsLabel, profileImageView, heartIcon, messageIcon, shareIcon ]
            .forEach { contentView.addSubview($0) }
        
        
    }
}

