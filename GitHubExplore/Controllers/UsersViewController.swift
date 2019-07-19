//
//  UsersViewController.swift
//  ExploreGitHub
//
//  Created by Pablo Cornejo on 7/17/19.
//  Copyright © 2019 Pablo Cornejo Pierola. All rights reserved.
//

import UIKit
import SafariServices

class UsersViewController: UICollectionViewController {
    
    // MARK: - Private properties
    
    private let itemsPerRow: CGFloat = 1
    private let itemSpacing: CGFloat = 20
    private lazy var sectionInsets = UIEdgeInsets(top: itemSpacing, left: itemSpacing, bottom: itemSpacing, right: itemSpacing)
    private var currentSearchTask: URLSessionDataTask?
    private var users: [GitHubUser] = [] {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
    }
    
    // MARK: - Table view data source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UserCell.self), for: indexPath) as! UserCell
        let user = users[indexPath.item]
        cell.configure(with: user, profileButtonTapHandler: showUserProfile(at:))
        if user.avatarImage == nil {
            startAvatarDownload(for: user, at: indexPath)
        }
        cell.backgroundColor = .groupTableViewBackground
        return cell
    }
    
    // MARK: - Private methods
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a GitHub user..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.becomeFirstResponder()
    }
    
    private func showUserProfile(at url: URL) {
        let safariVC = SFSafariViewController(url: url)
        if let presentedVC = presentedViewController {
            presentedVC.present(safariVC, animated: true)
        } else {
            present(safariVC, animated: true)
        }
    }
    
    private func startAvatarDownload(for user: GitHubUser, at indexPath: IndexPath) {
        let operation = AvatarDownloadOperation(for: user)
        operation.completionBlock = {
            AvatarDownloadOperation.downloadsInProgress[indexPath] = nil
            if operation.isCancelled { return }
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [indexPath])
            }
        }
        AvatarDownloadOperation.downloadQueue.addOperation(operation)
    }
}

extension UsersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        let userSearchEndpoint = GitHubEndpoint.userSearch(term: text)
        currentSearchTask?.cancel()
        currentSearchTask = URLSession.shared.dataTask(with: userSearchEndpoint.urlRequest) { [weak self] data, response, error in
            if let error = error { print(error); return }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else { return }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let usersSearchResult = try jsonDecoder.decode(UsersSearchResult.self, from: data)
                DispatchQueue.main.async {
                    self?.users = usersSearchResult.users
                }
            } catch {
                print(error)
            }
        }
        currentSearchTask?.resume()
    }
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalPaddingSpace: CGFloat = itemSpacing * (itemsPerRow - 1) + sectionInsets.left + sectionInsets.right
        let availableWidth = view.frame.width - totalPaddingSpace
        let itemWidth = availableWidth / itemsPerRow
        let aspectRatio: CGFloat = 2/1
        let itemHeigth = itemWidth / aspectRatio
        return CGSize(width: itemWidth, height: itemHeigth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
}
