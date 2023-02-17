//
//  RecordViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/17.
//

import UIKit

class RecordViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(
            RecordTableViewCell.self,
            forCellReuseIdentifier: RecordTableViewCell.identifier
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

extension RecordViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RecordTableViewCell.identifier,
            for: indexPath
        ) as? RecordTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }
}

extension RecordViewController: UITableViewDelegate {}

extension RecordViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: view.frame.width * 0.03
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: view.frame.width * -0.03
            ),
            tableView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: view.frame.height * 0.02
            ),
            tableView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: view.frame.height * -0.02
            )
        ])
    }
}
