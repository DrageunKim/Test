//
//  ListTableViewCell.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let visitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let menuLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        return label
    }()
    private let topStackView: UIStackView = {
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
    
    func configureLabel(data: Restaurant) {
        scoreLabel.text = data.score.description
        titleLabel.text = data.title
        visitLabel.text = data.visitDate.description
        menuLabel.text = data.menu.description
        locationLabel.text = data.location
    }
    
    private func configureContentView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 25
    }
    
    private func configureStackView() {
        topStackView.addArrangedSubview(scoreLabel)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(visitLabel)
        
        totalStackView.addArrangedSubview(topStackView)
        totalStackView.addArrangedSubview(menuLabel)
        totalStackView.addArrangedSubview(locationLabel)
    }
    
    private func configureLayout() {
        configureStackView()
        
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width * 0.07),
            totalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: contentView.frame.width * -0.07),
            totalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension ListTableViewCell: Identifiable {}
