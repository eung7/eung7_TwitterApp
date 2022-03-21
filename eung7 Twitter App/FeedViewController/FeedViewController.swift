//
//  FeedViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/20.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Feed"
    }
    
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
