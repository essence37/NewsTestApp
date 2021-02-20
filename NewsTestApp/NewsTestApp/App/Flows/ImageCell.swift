//
//  ImageCell.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 20.02.2021.
//

import UIKit

class ImageCell: UITableViewCell {
    let articleImage = UIImageView()
    static let reuseIdentifier = "image-cell-reuse-identifier"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageCell {
    func configure() {
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(articleImage)
        let imageInset = CGFloat(0)
        NSLayoutConstraint.activate([
            articleImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: imageInset),
            articleImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: imageInset),
            articleImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imageInset),
            articleImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: imageInset),
            articleImage.heightAnchor.constraint(equalTo: articleImage.widthAnchor, multiplier: 0.6)
        ])
    }
}
