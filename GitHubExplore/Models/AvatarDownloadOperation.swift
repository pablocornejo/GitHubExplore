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
        
        guard let imageData = try? Data(contentsOf: user.avatarUrl) else { return }
        
        if isCancelled { return }
        
        if !imageData.isEmpty {
            user.avatarImage = UIImage(data: imageData)
        }
    }
}
