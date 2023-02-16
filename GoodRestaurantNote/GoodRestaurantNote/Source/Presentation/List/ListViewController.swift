//
//  ListViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import UIKit

class ListViewController: UIViewController {
    
    typealias DataSource = UITableViewDiffableDataSource<Score, Restaurant>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Score, Restaurant>
    
    private lazy var dataSource = configureDataSource()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
    }
    
    private func configureDelegate() {
        tableView.delegate = self
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension ListViewController {
    private func configureDataSource() -> DataSource {
        let dataSource = DataSource(
            tableView: tableView,
            cellProvider: { tableView, indexPath, itemIdentifier in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: ListTableViewCell.identifier,
                    for: indexPath
                ) as? ListTableViewCell else {
                    return UITableViewCell()
                }
                
                return cell
            })
        return dataSource
    }
    
    private func configureSnapshot(data: [Restaurant], animation: Bool) {
        var snapshot = Snapshot()
        
        snapshot.appendSections([.good])
        snapshot.appendItems(data)
        
        dataSource.apply(snapshot, animatingDifferences: animation)
    }
}

extension ListViewController: UITableViewDelegate {}
