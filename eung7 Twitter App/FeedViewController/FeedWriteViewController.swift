//
//  FeedWriteViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import UIKit
import SnapKit

class FeedWriteViewController : UIViewController {
    
    let writeTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "닫기",
            style: .done,
            target: self,
            action: #selector(didTapClosedButton)
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .done,
            target: self,
            action: #selector(didTapSaveButton)
        )
    }
    
    @objc private func didTapClosedButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSaveButton() {
        print("iii")
    }
    
    private func setupLayout() {
        view.addSubview(writeTextView)
        writeTextView.font = .systemFont(ofSize: 16, weight: .bold)
        writeTextView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
