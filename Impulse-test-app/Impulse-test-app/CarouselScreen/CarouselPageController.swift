//
//  CarouselPageController.swift
//  Impulse-test-app
//
//  Created by Chernousova Maria on 02.09.2022.
//

import UIKit

class CarouselPageController: UIPageViewController {
    
    private var lastUpdatedViewControllerIndex = Int.zero
    private let carouselViewControllers = [
        CarouselViewController(),
        CarouselViewController(),
        CarouselViewController()
    ]
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.pageIndicatorTintColor = .contentPrimaryDisabled
        pageControl.currentPageIndicatorTintColor = .contentPrimary
        pageControl.numberOfPages = CarouselViewControllerData.data.count
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        return pageControl
    }()
    
    private let nextTitle = "Next"
    private let continueTitle = "Continue"
    
    private lazy var button: TemplateButton = {
        let button = TemplateButton(frame: .zero)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        button.setTitle(nextTitle, for: .normal)
        return button
    }()
    
    private var viewModel: CarouselViewModelProvider
    
    init(viewModel: CarouselViewModelProvider) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundPrimary
        
        setupUI()
        bindWithViewModel()
    }
    
    private func setupUI() {
        setupSubviews()
        setupAutoLayout()
    }
    
    private func setupSubviews() {
        view.addSubview(pageControl)
        view.addSubview(button)
        
        carouselViewControllers.forEach { vc in
            vc.dataSource = self
        }
        setViewControllers([carouselViewControllers[0]], direction: .forward, animated: true)
        
        dataSource = self
    }
    
    private func setupAutoLayout() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 52),
            button.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 28),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -58),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    private func bindWithViewModel() {
        viewModel.setShowAlertHandler { [weak self] alertData in
            self?.showAlert(
                title: alertData.title,
                message: alertData.message
            )
        }
    }
    
    private func showAlert(title: String, message: String) {
        let action = UIAlertAction(title: "OK",
                                   style: .cancel)
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    @objc private func pageControlValueChanged() {
        let pageIndex = pageControl.currentPage
        let viewController = carouselViewControllers[pageIndex]
        let direction: UIPageViewController.NavigationDirection = lastUpdatedViewControllerIndex < pageIndex ? .forward : .reverse
        setViewControllers([viewController], direction: direction, animated: true)
    }
    
    @objc private func didTapNextButton() {
        let pageIndex = lastUpdatedViewControllerIndex + 1
        if pageIndex != carouselViewControllers.count {
            let viewController = carouselViewControllers[pageIndex]
            setViewControllers([viewController], direction: .forward, animated: true)
        } else {
            viewModel.select()
        }
    }
}

extension CarouselPageController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = (carouselViewControllers as [UIViewController]).firstIndex(of: viewController),
           index != .zero {
            return carouselViewControllers[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = (carouselViewControllers as [UIViewController]).firstIndex(of: viewController),
           index != carouselViewControllers.count - 1 {
            return carouselViewControllers[index + 1]
        }
        return nil
    }
}

extension CarouselPageController: CarouselViewControllerDataSource {
    func carouselViewControllerData(_ carouselViewController: CarouselViewController) -> CarouselViewControllerDataRepresentable? {
        if let index = carouselViewControllers.firstIndex(of: carouselViewController) {
            let buttonTitle = index == CarouselViewControllerData.data.count - 1 ? continueTitle : nextTitle
            button.setTitle(buttonTitle, for: .normal)
            lastUpdatedViewControllerIndex = index
            pageControl.currentPage = index
            return CarouselViewControllerData.data[index]
        }
        return nil
    }
}
