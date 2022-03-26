//
//  FeedViewController.swift
//  eung7 Twitter App
//
//  Created by 김응철 on 2022/03/20.
//

import UIKit
import SnapKit
import Floaty

class FeedViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    
    let floaty = Floaty()
    
    var feeds : [Feed] = []
    var userInfo : UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFeed()
        loadUserInfo()
        
        setupNavigationBar()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        savingUserInfo()
        
        tableView.reloadData()
    }
    
    private func savingFeeds() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(feeds) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "Feeds")
        }
    }
    
    func savingUserInfo() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(userInfo) {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "UserInfo")
        }
    }
    
    private func loadUserInfo() {
        if let savedData = UserDefaults.standard.object(forKey: "UserInfo") as? Data {
            let decoder = JSONDecoder()
            guard let userInfo = try? decoder.decode(UserInfo.self, from: savedData) else { return }
            
            self.userInfo = userInfo
        }
    }
    
    private func loadFeed() {
        if let savedData = UserDefaults.standard.object(forKey: "Feeds") as? Data {
            let decoder = JSONDecoder()
            guard let feeds = try? decoder.decode([Feed].self, from: savedData) else { return }
            
            self.feeds = feeds
        }
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Feed"
    }
    
    private func setupLayout() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        tableView.rowHeight = 100
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        setupFloaty()
    }
    
    private func setupFloaty() {
        view.addSubview(floaty)
        floaty.sticky = true
        floaty.handleFirstItemDirectly = true
        floaty.paddingY = 55
        floaty.buttonImage = UIImage(systemName: "square.and.pencil")
        floaty.buttonColor = .white
        floaty.addItem(title: "") { [weak self] _ in
            guard let self = self else { return }
            let vc = FeedWriteViewController()
            vc.delegate = self
     
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FeedViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "FeedTableViewCell",
            for: indexPath)
                as? FeedTableViewCell else {
            return UITableViewCell()
        }
        cell.contentsLabel.text = feeds[indexPath.row].contents
        cell.heartButton.isSelected = feeds[indexPath.row].isHeart
        cell.usernameLabel.text = userInfo?.username
        cell.accountLabel.text = userInfo?.account
        cell.setupLayout()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        let vc = FeedDetailViewController()
        vc.contentsLabel.text = feeds[index].contents
        vc.index = index
        
        vc.completion = { [weak self] index in
            guard let self = self else { return }
            self.feeds.remove(at: index)
            
            self.savingFeeds()
            tableView.reloadData()
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FeedViewController : FeedWriteDelegate {
    func sendToText(vc: UIViewController, text: String) {
        let feed = Feed(contents: text, isHeart: false)
        self.feeds.insert(feed, at: 0)
        
        self.savingFeeds()
        tableView.reloadData()
    }
}

