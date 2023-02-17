//
//  DetailViewController.swift
//  GoodRestaurantNote
//
//  Created by yonggeun Kim on 2023/02/16.
//

import UIKit

class DetailViewController: UIViewController {

    private let mode: Mode
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()
    
    private let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(
            DetailCollectionViewCell.self,
            forCellWithReuseIdentifier: DetailCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.text = "종목"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    private let eventTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .label
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let eventStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .label
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    private let dateTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .label
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .label
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        return label
    }()
    private let bodyTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .label
        textField.layer.borderColor = UIColor.label.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    private let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureLayout()
        configureDelegate()
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDelegate() {
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 10
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if let item = collectionView.dequeueReusableCell(
            withReuseIdentifier: DetailCollectionViewCell.identifier,
            for: indexPath
        ) as? DetailCollectionViewCell {
            item.backgroundColor = .lightGray
            
           return item
        }

        return UICollectionViewCell()
    }
}

extension DetailViewController: UICollectionViewDelegate {}

extension DetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureStackView() {
        eventStackView.addArrangedSubview(eventLabel)
        eventStackView.addArrangedSubview(eventTextField)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleTextField)
        
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dateTextField)
        
        locationStackView.addArrangedSubview(locationLabel)
        locationStackView.addArrangedSubview(locationTextField)
        
        bodyStackView.addArrangedSubview(bodyLabel)
        bodyStackView.addArrangedSubview(bodyTextField)
    }
    
    private func configureLayout() {
        configureStackView()
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(imageCollectionView)
        contentScrollView.addSubview(eventStackView)
        contentScrollView.addSubview(titleStackView)
        contentScrollView.addSubview(dateStackView)
        contentScrollView.addSubview(locationStackView)
        contentScrollView.addSubview(bodyStackView)
        
        NSLayoutConstraint.activate([
            contentScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentScrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            contentScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageCollectionView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            imageCollectionView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            imageCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            eventStackView.topAnchor.constraint(equalTo: imageCollectionView.bottomAnchor),
            eventStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            eventStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            eventTextField.widthAnchor.constraint(
                equalTo: contentScrollView.widthAnchor,
                multiplier: 0.7
            ),

            titleStackView.topAnchor.constraint(equalTo: eventStackView.bottomAnchor),
            titleStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            titleStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            titleTextField.widthAnchor.constraint(
                equalTo: contentScrollView.widthAnchor,
                multiplier: 0.7
            ),
            
            dateStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            dateStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            dateStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            dateTextField.widthAnchor.constraint(
                equalTo: contentScrollView.widthAnchor,
                multiplier: 0.7
            ),
            
            locationStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor),
            locationStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            locationStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            locationTextField.widthAnchor.constraint(
                equalTo: contentScrollView.widthAnchor,
                multiplier: 0.7
            ),
            
            bodyStackView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor),
            bodyStackView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            bodyStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            bodyTextField.widthAnchor.constraint(
                equalTo: contentScrollView.widthAnchor,
                multiplier: 0.7
            )
        ])
    }
}
