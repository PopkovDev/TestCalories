//
//  productsViewController.swift
//  TestCalories
//
//  Created by Андрей Попков on 08.10.2024.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// Экран для показа списка продуктов
final class ProductsViewController: UIViewController {

    // MARK: - Constants
    
    private let viewModel: ProductsViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Visual Components

    let productsView = ProductsView()

    // MARK: - Initializers
    
    init(viewModel: ProductsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        configureConstraints()
        bindViewModel()
    }

    // MARK: - Public Methods
    
    private func setupSubviews() {
        view.backgroundColor = .background
        view.addSubviews([
            productsView
        ])
    }
    
    private func configureConstraints() {
        configureProductsViewConstraints()
    }

    private func bindViewModel() {
        /*
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.query)
            .disposed(by: disposeBag)

        viewModel.products
            .bind(to: tableView.rx.items(cellIdentifier: "ProductCell", cellType: UITableViewCell.self)) { row, product, cell in
                cell.textLabel?.text = "\(product.name) - \(product.calories) kcal"
            }
            .disposed(by: disposeBag)

        categoryButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showCategoryPicker()
            })
            .disposed(by: disposeBag)

        brandButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.showBrandPicker()
            })
            .disposed(by: disposeBag)
         */
    }

    private func showCategoryPicker() {
        /*
        let alert = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        viewModel.categories
            .subscribe(onNext: { [weak self] categories in
                categories.forEach { category in
                    let action = UIAlertAction(title: category, style: .default) { _ in
                        self?.viewModel.filterProductsByCategory(category)
                        self?.categoryButton.setTitle(category, for: .normal)
                    }
                    alert.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancelAction)
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
         */
    }

    private func showBrandPicker() {
        /*
        let alert = UIAlertController(title: "Select Brand", message: nil, preferredStyle: .actionSheet)
        viewModel.brands
            .subscribe(onNext: { [weak self] brands in
                brands.forEach { brand in
                    let action = UIAlertAction(title: brand, style: .default) { _ in
                        self?.viewModel.filterProductsByBrand(brand)
                        self?.brandButton.setTitle(brand, for: .normal)
                    }
                    alert.addAction(action)
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancelAction)
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
         */
    }
}

extension ProductsViewController {
    private func configureProductsViewConstraints() {
        NSLayoutConstraint.activate([
            productsView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            productsView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            productsView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            productsView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
}
