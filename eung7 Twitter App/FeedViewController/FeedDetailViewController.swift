//
//  FeedDetailViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import UIKit
import SnapKit

class FeedDetailViewController : UIViewController {
    
    var index : Int = 0
    
    var completion : ((Int) -> Void)?
    
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let accountLabel = UILabel()
    let contentsLabel = UILabel()
    let heartButton = UIButton()
    let shareBUtton = UIButton()
    let modifyButton = UIButton()

    let buttonStackView = UIStackView()
    
    lazy var deleteButton : UIBarButtonItem = {
        let rightBarButton = UIBarButtonItem(
            title: "삭제",
            style: .done,
            target: self,
            action: #selector(didTapDeleteButton)
        )
        
        return rightBarButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateContents()
    }
    
    private func updateContents() {
        contentsLabel.text = Feed.currentFeeds[index].contents
    }
    
    @objc func didTapDeleteButton() {
        completion?(index)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapHeartButton() {
        if heartButton.isSelected {
            heartButton.isSelected = false
            Feed.currentFeeds[index].isHeart = false
        } else {
            heartButton.isSelected = true
            Feed.currentFeeds[index].isHeart = true
        }
    }
    
    @objc private func didTapModifyButton() {
        let vc = FeedWriteViewController()
        vc.editorMode = .editor(index)
        vc.writeTextView.text = Feed.currentFeeds[index].contents

        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupLayout() {
        self.deleteButton.tintColor = .systemRed
        self.navigationItem.rightBarButtonItem = deleteButton
        view.backgroundColor = .systemBackground
        
        [ heartButton, shareBUtton ]
            .forEach { buttonStackView.addArrangedSubview($0) }
        
        heartButton.tintColor = .systemMint
        heartButton.isSelected = Feed.currentFeeds[index].isHeart
        heartButton.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        
        shareBUtton.tintColor = .systemMint
        
        [ profileImageView, usernameLabel, accountLabel, contentsLabel, buttonStackView, modifyButton ]
            .forEach { view.addSubview($0) }
        
        profileImageView.backgroundColor = .gray
        profileImageView.layer.cornerRadius = 25
        profileImageView.layer.masksToBounds = true
        profileImageView.image = UserInfo.currentUserInfo.profileImage.toImage()
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(50)
        }
        
        usernameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.top.equalTo(profileImageView.snp.top).offset(5)
        }
        
        accountLabel.font = .systemFont(ofSize: 12, weight: .light)
        accountLabel.textColor = .secondaryLabel
        accountLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(usernameLabel.snp.leading)
        }
        
        contentsLabel.font = .systemFont(ofSize: 15, weight: .regular)
        contentsLabel.numberOfLines = 0
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalSpacing
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        shareBUtton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(100)
            $0.trailing.equalToSuperview().inset(100)
        }
        
        modifyButton.addTarget(self, action: #selector(didTapModifyButton), for: .touchUpInside)
        modifyButton.setTitle("수정하기", for: .normal)
        modifyButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        modifyButton.layer.cornerRadius = 10
        modifyButton.tintColor = .systemMint
        modifyButton.backgroundColor = .systemMint
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
