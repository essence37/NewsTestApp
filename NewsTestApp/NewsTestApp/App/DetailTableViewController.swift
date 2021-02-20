//
//  DetailTableViewController.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 20.02.2021.
//

import UIKit
import Kingfisher

class DetailTableViewController: UITableViewController {
    
    enum Sections: CaseIterable {
        case image
        case title
        case information
    }
    
    let article: Article
    
    init(article: Article) {
        self.article = article
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseIdentifier)
        tableView.register(TitleCell.self, forCellReuseIdentifier: TitleCell.reuseIdentifier)
        tableView.register(InformationCell.self, forCellReuseIdentifier: InformationCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sections.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch Sections.allCases[indexPath.row] {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
            cell.articleImage.kf.setImage(with: URL(string: article.urlToImage ?? ""))
            cell.articleImage.contentMode = .scaleAspectFit
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleCell.reuseIdentifier, for: indexPath) as! TitleCell
            cell.label.text = article.title
            cell.label.numberOfLines = 0
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
            return cell
        case .information:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationCell.reuseIdentifier, for: indexPath) as! InformationCell
            cell.label.text = article.description
            cell.label.numberOfLines = 0
            cell.label.lineBreakMode = .byWordWrapping
            cell.label.textAlignment = .left
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }

}
