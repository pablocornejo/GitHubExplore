//
//  UserCell.swift
//  ExploreGitHub
//
//  Created by Pablo Cornejo on 7/17/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit

protocol UserCellDelegate: class {
    func didTapViewProfileButton(for user: GitHubUser)
    func didTapRepositoriesButton(for user: GitHubUser)
}

class UserCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var repositoriesButton: UIButton!
    
    private weak var user: GitHubUser?
    weak var delegate: UserCellDelegate?
    
    @IBAction func didTapProfileButton() {
        guard let user = user else { return }
        delegate?.didTapViewProfileButton(for: user)
    }
    
    @IBAction func didTapRepositoriesButton() {
        guard let user = user else { return }
        delegate?.didTapRepositoriesButton(for: user)
    }
    
    func configure(with user: GitHubUser, delegate: UserCellDelegate) {
        imageView.image = user.avatarImage
        usernameLabel.text = user.username
        repositoriesButton.isHidden = user.repositories == nil
        self.user = user
        self.delegate = delegate
    }
}
