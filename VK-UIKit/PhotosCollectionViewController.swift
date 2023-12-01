//
//  PhotosCollectionViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    static let name = "Photos"
    private let networkService = NetworkService()
    private var photos = [Photo]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Self.name
        self.collectionView!.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier
        )
        collectionView.refreshControl = UIRefreshControl()
        updatePhotos()
        collectionView.refreshControl?.addTarget(
            self,
            action: #selector(updatePhotos),
            for: .valueChanged
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = Self.name
        tabBarController?.navigationItem.rightBarButtonItem = nil
        collectionView.backgroundColor = Theme.backgroundColor
    }

    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.identifier,
            for: indexPath
        ) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: photos[indexPath.row])
        
        return cell
    }
    
    // MARK: - Setup UI
    
    @objc private func updatePhotos() {
        networkService.getPhotos { [weak self] photos in
            self?.photos = photos
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.collectionView.refreshControl?.endRefreshing()
            }
        }
    }
    
    /// Creates a custom layout.
    /// - Returns: A custom layout for `PhotosCollectionViewController`.
    static func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2, leading: 2, bottom: 2, trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.18)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}
