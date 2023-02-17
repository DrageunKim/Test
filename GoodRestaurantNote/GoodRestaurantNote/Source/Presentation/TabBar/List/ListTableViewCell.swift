//
//  ListTableViewCell.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    private let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .add
        return imageView
    }()
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let locationDateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureContentView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
//        imageView.image = nil
        eventLabel.text = nil
        titleLabel.text = nil
        dateLabel.text = nil
        locationLabel.text = nil
    }
    
    func configureLabel(data: MatchInfo) {
//        infoImageView.image = data.images[index]
        titleLabel.text = data.title
        eventLabel.text = data.event
        dateLabel.text = data.date.description
        locationLabel.text = data.location
    }
    
    private func configureContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 25
    }
    
    private func configureStackView() {
        locationDateStackView.addArrangedSubview(locationLabel)
        locationDateStackView.addArrangedSubview(dateLabel)
        
        totalStackView.addArrangedSubview(eventLabel)
        totalStackView.addArrangedSubview(titleLabel)
        totalStackView.addArrangedSubview(locationDateStackView)
    }
    
    private func configureLayout() {
        configureStackView()
        
        contentView.addSubview(infoImageView)
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            infoImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: contentView.frame.width * 0.03
            ),
            infoImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: contentView.frame.height * 0.02
            ),
            infoImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: contentView.frame.height * -0.02
            ),
            infoImageView.widthAnchor.constraint(
                equalTo: infoImageView.heightAnchor
            ),
            
            totalStackView.leadingAnchor.constraint(
                equalTo: infoImageView.trailingAnchor,
                constant: contentView.frame.width * 0.03
            ),
            totalStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: contentView.frame.width * -0.05
            ),
            totalStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: contentView.frame.height * 0.1
            ),
            totalStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: contentView.frame.height * -0.1
            )
        ])
    }
}

extension ListTableViewCell: Identifiable {}
