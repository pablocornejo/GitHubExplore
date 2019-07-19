//
//  RepositoryCell.swift
//  GitHubExplore
//
//  Created by Pablo Cornejo on 7/19/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var openIssuesLabel: UILabel!
    @IBOutlet var forksLabel: UILabel!
    
    func configure(with repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description ?? "(No description)"
        openIssuesLabel.text = "Open Issues: \(repository.openIssuesCount)"
        forksLabel.text = "Forks: \(repository.forksCount)"
    }
}
