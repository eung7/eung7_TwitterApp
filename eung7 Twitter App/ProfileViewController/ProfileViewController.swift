//
//  ProfileViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/20.
//

import UIKit
import SnapKit
import PhotosUI

class ProfileViewController : UIViewController {
    
    let usernameTextField = UITextField()
    let accountTextField = UITextField()
    let profileImage = UIImageView()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configurationPHPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc private func didTapProfileImageView() {
        configurationPHPicker()
    }
    
    @objc private func didTapSaveButton() {
        let userInfo = UserInfo(
            username: usernameTextField.text ?? "",
            account: accountTextField.text ?? ""
        )
        
        UserInfo.currentUserInfo = userInfo
        
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
            saveButton.backgroundColor = .systemMint
        }
    }
    
    private func setupLayout() {
        navigationItem.title = "Profile"
        
        [ profileImage, usernameTextField, accountTextField, saveButton ]
            .forEach { view.addSubview($0) }
        
        let tapProfileImageView = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView))
        
        profileImage.backgroundColor = .gray
        profileImage.layer.cornerRadius = 25
        profileImage.addGestureRecognizer(tapProfileImageView)
        profileImage.isUserInteractionEnabled = true
        profileImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.height.equalTo(50)
        }
        
        usernameTextField.text = UserInfo.currentUserInfo.username
        usernameTextField.font = .systemFont(ofSize: 20, weight: .bold)
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.leading.equalTo(profileImage.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        accountTextField.text = UserInfo.currentUserInfo.account
        accountTextField.font = .systemFont(ofSize: 16, weight: .regular)
        accountTextField.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(8)
            $0.leading.equalTo(profileImage.snp.trailing).offset(8)
        }
        
        saveButton.setTitle("저장하기", for: .normal)
        saveButton.backgroundColor = .systemMint
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
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 12 else { return false }
        return true
    }
}

extension ProfileViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
    }
}
