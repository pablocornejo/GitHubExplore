//
//  GitHubEndpoint.swift
//  ExploreGitHub
//
//  Created by Pablo Cornejo on 7/17/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    var urlRequest: URLRequest {
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
}

enum GitHubEndpoint: Endpoint {
    
    case userSearch(term: String)
    
    var base: String { return "https://api.github.com" }
    var path: String {
        switch self {
        case .userSearch: return "/search/users"
        }
    }
    var queryItems: [URLQueryItem] {
        switch self {
        case .userSearch(let term):
            let termItem = URLQueryItem(name: "q", value: term)
            return [termItem]
        }
    }
    
}
