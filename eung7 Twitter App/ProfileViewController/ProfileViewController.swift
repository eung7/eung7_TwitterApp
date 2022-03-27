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
    
    var completion : ((UserInfo) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.delegate = self
        accountTextField.delegate = self
        
        usernameTextField.addTarget(self, action: #selector(didChangedTextField(_:)), for: .editingChanged)
        accountTextField.addTarget(self, action: #selector(didChangedTextField(_:)), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        
        setupLayout()
    }
    
    @objc private func didTapSaveButton() {
        let userInfo = UserInfo(
            username: usernameTextField.text ?? "",
            account: accountTextField.text ?? ""
        )
        
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(userInfo) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "UserInfo")
        }
        
        completion?(userInfo)
    }
    
    @objc private func didChangedTextField(_ textField : UITextField) {
        if usernameTextField.text?.isEmpty == true ||
            accountTextField.text?.isEmpty == true {
            saveButton.isEnabled = false
            saveButton.setTitle("빈칸을 입력해주세요.", for: .disabled)
            saveButton.backgroundColor = .systemGray
        } else {
            saveButton.isEnabled = true
            saveButton.setTitle("저장하기", for: .normal)
            saveButton.backgroundColor = .systemPink
        }
    }
    
    private func setupLayout() {
        navigationItem.title = "Profile"
        
        [ usernameTextField, accountTextField, saveButton ]
            .forEach { view.addSubview($0) }
        
        usernameTextField.text = UserInfo.defaultData.username
        usernameTextField.font = .systemFont(ofSize: 20, weight: .bold)
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        accountTextField.text = UserInfo.defaultData.account
        accountTextField.font = .systemFont(ofSize: 16, weight: .regular)
        accountTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(8)
            $0.leading.equalTo(usernameTextField.snp.leading)
        }
        
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.backgroundColor = .systemPink
        saveButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        saveButton.layer.cornerRadius = 10
        saveButton.snp.makeConstraints {
            $0.top.equalTo(accountTextField.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}

extension ProfileViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }

        guard text.count <= 12 else { return false }

        return true
    }
}
