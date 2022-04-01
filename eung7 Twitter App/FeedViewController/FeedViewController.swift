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
    
    var feeds : [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Feed"
        
        self.feeds = UserDefaultsManager.loadFeed()
        UserInfo.shared = UserDefaultsManager.loadUserInfo()
        
        setupTableView()
        setupRefreshControl()
        setupFloaty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(UserInfo.shared)
        print(feeds)
        
        tableView.reloadData()
    }
    
    private func setupRefreshControl() {
        let refresh = UIRefreshControl()

        tableView.refreshControl = refresh
        tableView.refreshControl?.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
    }
    
    @objc private func pullRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedTableViewCell")
        tableView.rowHeight = 100
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupFloaty() {
        let floaty = Floaty(size: 50.0)
        
        view.addSubview(floaty)
        floaty.paddingY = 100.0
        floaty.sticky = true
        floaty.handleFirstItemDirectly = true
        floaty.buttonImage = UIImage(systemName: "square.and.pencil")
        floaty.buttonColor = .systemMint
        floaty.plusColor = .systemBackground
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else {
            return UITableViewCell() }
        let index = indexPath.row
        let feed = feeds[index]
        
        cell.setup(feed: feed)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let feed = feeds[index]
        
        let vc = FeedDetailViewController(feed: feed)
        vc.completion = { [weak self] index in
            guard let self = self else { return }
            let feeds = self.feeds.remove(at: index)
            DispatchQueue.global().async {
                UserDefaultsManager.saveFeed(feed: feed)
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let feeds = feeds.remove(at: indexPath.row)
            DispatchQueue.global().async {
                UserDefaultsManager.saveFeed(feed: feeds)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FeedViewController : FeedWriteDelegate {
    func sendToText(text: String) {
        let feed = Feed(contents: text, isHeart: false)
        UserDefaultsManager.saveFeed(feed: feed)
        feeds.insert(feed, at: 0)
    }
}
