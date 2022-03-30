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
    let refresh = UIRefreshControl()
    let floaty = Floaty(size: 50.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @objc private func pullRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }
    
    private func setupLayout() {
        self.navigationItem.title = "Feed"
        tableView.refreshControl = refresh
        tableView.refreshControl?.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)

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
        return Feed.currentFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "FeedTableViewCell",
            for: indexPath)
                as? FeedTableViewCell else {
            return UITableViewCell()
        }
        cell.contentsLabel.text = Feed.currentFeeds[index].contents
        cell.heartButton.isSelected = Feed.currentFeeds[index].isHeart
        cell.usernameLabel.text = UserInfo.currentUserInfo.username
        cell.accountLabel.text = "@\(UserInfo.currentUserInfo.account)"
        
        let profileImage = UserInfo.currentUserInfo.profileImage.toImage()
        cell.profileImageView.image = profileImage
        
        cell.index = index
        cell.selectionStyle = .default
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        let vc = FeedDetailViewController()
        vc.index = index
        vc.contentsLabel.text = Feed.currentFeeds[index].contents
        vc.accountLabel.text = "@\(UserInfo.currentUserInfo.account)"
        vc.usernameLabel.text = UserInfo.currentUserInfo.username
        
        vc.completion = { [weak self] index in
            guard let self = self else { return }
            Feed.currentFeeds.remove(at: index)
        }
    
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Feed.currentFeeds.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension FeedViewController : FeedWriteDelegate {
    func sendToText(vc: UIViewController, text: String) {
        let feed = Feed(contents: text, isHeart: false)
        Feed.currentFeeds.insert(feed, at: 0)
    }
}
