//
//  AvatarDownloadOperation.swift
//  GitHubExplore
//
//  Created by Pablo Cornejo on 7/18/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit

class AvatarDownloadOperation: Operation {
    static var downloadsInProgress: [IndexPath: Operation] = [:]
    static var downloadQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Avatars Download Queue"
        return queue
    }()
    
    private let user: GitHubUser
    
    init(for user: GitHubUser) {
        self.user = user
    }
    
    override func main() {
        if isCancelled { return }
        
        var data: Data?
        do {
            data = try Data(contentsOf: user.avatarUrl)
        } catch {
            print(error)
        }
        guard let imageData = data, !isCancelled else { return }
        
        if !imageData.isEmpty {
            user.avatarImage = UIImage(data: imageData)
        }
    }
}
