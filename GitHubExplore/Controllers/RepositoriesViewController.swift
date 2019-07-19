//
//  RepositoriesViewController.swift
//  GitHubExplore
//
//  Created by Pablo Cornejo on 7/19/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit
import SafariServices

class RepositoriesViewController: UITableViewController {

    var repositories: [Repository]!
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepositoryCell.self), for: indexPath) as! RepositoryCell
        let repository = repositories[indexPath.row]
        cell.configure(with: repository)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        let safariVC = SFSafariViewController(url: repository.htmlUrl)
        present(safariVC, animated: true)
    }
}
