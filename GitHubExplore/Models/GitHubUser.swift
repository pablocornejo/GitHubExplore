//
//  GitHubUser.swift
//  ExploreGitHub
//
//  Created by Pablo Cornejo on 7/17/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit

struct UsersSearchResult: Decodable {
    let users: [GitHubUser]
    
    enum CodingKeys: String, CodingKey {
        case users = "items"
    }
}

struct GitHubUser: Decodable {
    let avatarUrl: URL
    let username: String
    let url: URL
    let htmlUrl: URL
    let reposUrl: URL
    var avatarImage: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl
        case username = "login"
        case url
        case htmlUrl
        case reposUrl
    }
}