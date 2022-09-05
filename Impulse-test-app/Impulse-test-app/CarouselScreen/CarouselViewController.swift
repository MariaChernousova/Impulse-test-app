//
//  CarouselViewController.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

protocol CarouselViewControllerDataRepresentable {
    var image: UIImage? { get }
    var title: String { get }
    var description: String { get }
}

protocol CarouselViewControllerDataSource: AnyObject {
    func carouselViewControllerData(_ carouselViewController: CarouselViewController) -> CarouselViewControllerDataRepresentable?
}

class CarouselViewController: UIViewController {

    weak var dataSource: CarouselViewControllerDataSource?
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .contentPrimary
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 16)
        label.textColor = .contentPrimary
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let data = dataSource?.carouselViewControllerData(self) {
            setup(with: data)
        }
    }
    
    private func setup(with data: CarouselViewControllerDataRepresentable) {
        contentImageView.image = data.image
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
    
    private func setupUI() {
        setupSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviews() {
        view.addSubview(contentImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    private func setupAutoLayout() {
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            contentImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 146),
            contentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            contentImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 36),
            titleLabel.topAnchor.constraint(equalTo: contentImageView.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            descriptionLabel.heightAnchor.constraint(equalToConstant: 48),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
}
