//
//  FeedDetailViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import UIKit
import SnapKit

class FeedDetailViewController : UIViewController {
    
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let accountLabel = UILabel()
    let contentsLabel = UILabel()
    let heartButton = UIButton()
    let shareBUtton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    private func setupLayout() {
        [ profileImageView, usernameLabel, accountLabel, contentsLabel, heartButton, shareBUtton ]
            .forEach { view.addSubview($0) }
        
        profileImageView.backgroundColor = .gray
        profileImageView.layer.cornerRadius = 25
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(50)
        }
    }
}
