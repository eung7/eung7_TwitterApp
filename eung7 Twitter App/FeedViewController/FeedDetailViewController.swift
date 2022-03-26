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
    
    @objc func didTapDeleteButton() {
        completion?(index)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setupLayout() {
        self.deleteButton.tintColor = .systemRed
        self.navigationItem.rightBarButtonItem = deleteButton
        view.backgroundColor = .systemBackground
        
        [ heartButton, shareBUtton ]
            .forEach { buttonStackView.addArrangedSubview($0) }
        
        [ profileImageView, usernameLabel, accountLabel, contentsLabel, buttonStackView ]
            .forEach { view.addSubview($0) }
        
        profileImageView.backgroundColor = .gray
        profileImageView.layer.cornerRadius = 25
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(50)
        }
        
        usernameLabel.text = "KimEungCheol"
        usernameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        usernameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.top.equalTo(profileImageView.snp.top).offset(5)
        }
        
        accountLabel.text = "@eung7"
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
        shareBUtton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(100)
            $0.trailing.equalToSuperview().inset(100)
        }
    }
}

