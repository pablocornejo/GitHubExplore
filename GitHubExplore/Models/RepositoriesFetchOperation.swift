//
//  RepositoryFetchOperation.swift
//  GitHubExplore
//
//  Created by Pablo Cornejo on 7/18/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import Foundation

class RepositoriesFetchOperation: Operation {
    static var fetchesInProgress: [IndexPath: Operation] = [:]
    static var fetchQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Repositories Fetch Queue"
        return queue
    }()
    
    private let user: GitHubUser
    
    init(for user: GitHubUser) {
        self.user = user
    }
    
    override func main() {
        if isCancelled { return }
        
        var repositoriesData: Data?
        do {
            repositoriesData = try Data(contentsOf: user.reposUrl)
        } catch {
            print(error)
        }
        guard let reposData = repositoriesData, !isCancelled else { return }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        var repositories: [Repository]?
        do {
            repositories = try jsonDecoder.decode([Repository].self, from: reposData)
        } catch {
            print(error)
        }
        
        if let repositories = repositories {
            user.repositories = repositories
        }
    }
}
