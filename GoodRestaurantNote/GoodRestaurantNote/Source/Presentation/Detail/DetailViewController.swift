//
//  DetailViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
}

extension DetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
}
