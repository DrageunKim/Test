//
//  ListViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import UIKit

class ListViewController: UIViewController {
    
    private let viewModel = ListViewModel()
    
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
        configureDelegate()
        configureLayout()
    }
    
    private func configureDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier,
            for: indexPath
        ) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.dataList[indexPath.row]
        
        cell.configureLabel(data: data)
        
        return cell
    }
}

extension ListViewController: UITableViewDelegate {}

extension ListViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: view.frame.width * 0.03),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: view.frame.width * -0.03),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
