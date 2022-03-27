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
    
    @objc func didTapHeartButton() {
        if heartButton.isSelected == false {
            heartButton.isSelected = true
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        } else {
            heartButton.isSelected = false
        }
    }
    
    func setupLayout() {
        [ heartButton, messageButton, shareButton, usernameLabel, accountLabel, contentsLabel, profileImageView ]
            .forEach { contentView.addSubview($0) }
        
        messageButton.setImage(UIImage(systemName: "message"), for: .normal)
        messageButton.tintColor = .systemMint
        messageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }

        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        heartButton.tintColor = .systemMint
        heartButton.snp.makeConstraints {
            $0.leading.equalTo(usernameLabel.snp.leading).offset(15)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }

        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemMint
        shareButton.snp.makeConstraints {
            $0.leading.equalTo(messageButton.snp.trailing).offset(60)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }
    
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
        contentsLabel.numberOfLines = 1
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(usernameLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(16)
        }

    }
}
