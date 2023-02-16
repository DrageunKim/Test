//
//  DetailViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import UIKit

class DetailViewController: UIViewController {

    private let mode: Mode
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
}
