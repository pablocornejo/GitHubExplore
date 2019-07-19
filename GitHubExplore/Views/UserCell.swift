//
//  UserCell.swift
//  ExploreGitHub
//
//  Created by Pablo Cornejo on 7/17/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    
    private var profileUrl: URL?
    private var profileButtonTapHandler: ((URL) -> Void)?
    
    @IBAction func didTapProfileButton() {
        guard let profileUrl = profileUrl else { return }
        profileButtonTapHandler?(profileUrl)
    }
    
    func configure(with user: GitHubUser, profileButtonTapHandler: ((URL) -> Void)?) {
        imageView.image = user.avatarImage
        usernameLabel.text = user.username
        profileUrl = user.htmlUrl
        self.profileButtonTapHandler = profileButtonTapHandler
    }
}
