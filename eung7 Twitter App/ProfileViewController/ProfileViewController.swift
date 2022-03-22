//
//  ProfileViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/20.
//

import UIKit
import SnapKit

class ProfileViewController : UIViewController {
    
    let usernameTextField = UITextField()
    let accountTextField = UITextField()
    let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Profile"
    }
    
    private func setupLayout() {
        [ usernameTextField, accountTextField, saveButton ]
            .forEach { view.addSubview($0) }
        
        usernameTextField.text = "KimEungCheol"
        usernameTextField.font = .systemFont(ofSize: 20, weight: .bold)
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        
        accountTextField.text = "eung7"
        accountTextField.font = .systemFont(ofSize: 16, weight: .regular)
        accountTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(8)
            $0.leading.equalTo(usernameTextField.snp.leading)
        }
        
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        saveButton.layer.cornerRadius = 10
        saveButton.backgroundColor = .systemBlue
        saveButton.snp.makeConstraints {
            $0.top.equalTo(accountTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

