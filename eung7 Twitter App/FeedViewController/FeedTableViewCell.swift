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
    
    let heartButton = UIButton()
    let messageButton = UIButton()
    let shareButton = UIButton()
    
    func setupLayout() {
        [ usernameLabel, accountLabel, contentsLabel, profileImageView, heartButton, messageButton, shareButton ]
            .forEach { contentView.addSubview($0) }
    
        profileImageView.backgroundColor = .gray
        profileImageView.layer.cornerRadius = 25
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(50)
        }
        
        usernameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        accountLabel.font = .systemFont(ofSize: 12, weight: .light)
        accountLabel.textColor = .secondaryLabel
        accountLabel.snp.makeConstraints {
            $0.centerY.equalTo(usernameLabel)
            $0.leading.equalTo(usernameLabel.snp.trailing).offset(4)
        }
        
        contentsLabel.font = .systemFont(ofSize: 14)
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(usernameLabel.snp.leading)
        }

        messageButton.setImage(UIImage(systemName: "message"), for: .normal)
        messageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }

        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.snp.makeConstraints {
            $0.leading.equalTo(usernameLabel.snp.leading).offset(15)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }

        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.snp.makeConstraints {
            $0.leading.equalTo(messageButton.snp.trailing).offset(60)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
    }
}
