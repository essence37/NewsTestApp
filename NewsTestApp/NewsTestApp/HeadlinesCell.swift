//
//  HeadlinesCell.swift
//  NewsTestApp
//
//  Created by Пазин Даниил on 18.02.2021.
//

import UIKit

class HeadlinesCell: UICollectionViewCell {
    let label = UILabel()
    let image = UIImageView()
    static let reuseIdentifier = "text-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

extension HeadlinesCell {
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        contentView.addSubview(label)
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
        
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        let imageInset = CGFloat(0)
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: imageInset),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: imageInset),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: imageInset),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: imageInset)
        ])
    }
}
