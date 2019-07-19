//
//  Repository.swift
//  GitHubExplore
//
//  Created by Pablo Cornejo on 7/18/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let description: String?
    let htmlUrl: URL
    let openIssuesCount: Int
    let forksCount: Int
}
