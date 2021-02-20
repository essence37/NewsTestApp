//
//  MainViewController.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 17.02.2021.
//

import UIKit
import Combine
import Kingfisher

class MainViewController: UIViewController {
    
    enum Section {
        case main
    }

    // MARK: - Constants&Variables
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Article>! = nil
    var collectionView: UICollectionView! = nil
    
    let apiClient = APIClient()
    var subscriptions: Set<AnyCancellable> = []
    var news = [Article]()
    
    // MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News Test App"
        configureHierarchy()
        configureDataSource()
        
        fetchNews()
    }
    
    // MARK: - Methods
    
    func fetchNews() {
        // Проверка, нет ли активного запроса.
        apiClient.headlinesByCountry(country: Method.NewsCountries.russia)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.onFetchFailed(with: error.localizedDescription)
                }
            }, receiveValue: { object in
                switch object {
                case .success(let newsObject):
                    // Добавление полученного значения в массив.
                    self.news.append(contentsOf: newsObject.articles)
                    var currentSnapshot = self.dataSource.snapshot()
                    currentSnapshot.appendItems(self.news, toSection: .main)
                    self.dataSource.apply(currentSnapshot)
                    currentSnapshot.reloadItems(self.news)
                case .failure(let errorObject):
                    self.onFetchFailed(with: errorObject.message)
                }
            })
            .store(in: &subscriptions)
    }
    
    func onFetchFailed(with reason: String) {
        let alert = UIAlertController(title: "Warning", message: reason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

}

extension MainViewController {
    /// - Tag: TwoColumn
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(244))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MainViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<HeadlinesCell, Article> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
            cell.label.text = identifier.title
            cell.image.kf.setImage(with: URL(string: identifier.urlToImage!))
            cell.contentView.backgroundColor = .lightGray
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Article>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Article) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(news)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
