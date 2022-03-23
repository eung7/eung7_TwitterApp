//
//  FeedWriteViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/22.
//

import UIKit
import SnapKit

protocol FeedWriteDelegate : AnyObject {
    func sendToText(vc : UIViewController, text : String)
}

class FeedWriteViewController : UIViewController {
    
    let writeTextView = UITextView()
    
    weak var delegate : FeedWriteDelegate?
    
    let cancelButton = UIBarButtonItem(
        title: "닫기",
        style: .done,
        target: self,
        action: #selector(didTapClosedButton)
    )
    
    let saveButton = UIBarButtonItem(
        title: "저장",
        style: .done,
        target: self,
        action: #selector(didTapSaveButton)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .systemBackground
        
        setupLayout()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        writeTextView.becomeFirstResponder()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
    }
    
    @objc private func didTapClosedButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapSaveButton() {
        guard let text = writeTextView.text else { return }
        self.delegate?.sendToText(vc: self, text: text)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setupLayout() {
        view.addSubview(writeTextView)
        writeTextView.font = .systemFont(ofSize: 16, weight: .bold)
        writeTextView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}


