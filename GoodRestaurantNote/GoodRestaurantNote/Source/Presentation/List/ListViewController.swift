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
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(.add, for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureDelegate()
        configureLayout()
        configureButtonAction()
    }
    
    private func configureButtonAction() {
        addButton.addTarget(self, action: #selector(tappedAddButton), for: .touchDown)
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
    @objc
    private func tappedAddButton() {
        let pushViewController = DetailViewController()
        
        navigationController?.pushViewController(pushViewController, animated: true)
    }
}

extension ListViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor),
            addButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: view.frame.width * -0.1
            ),
            addButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: view.frame.height * -0.1
            ),
            tableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: view.frame.width * 0.03
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: view.frame.width * -0.03
            ),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
