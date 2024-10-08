//
//  ProductSearchViewController.swift
//  TestCalories
//
//  Created by Андрей Попков on 08.10.2024.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ProductSearchViewController: UIViewController {

    private let viewModel: ProductSearchViewModel
    private let disposeBag = DisposeBag()

    private let searchBar = UISearchBar()
    private let categoryButton = UIButton()
    private let brandButton = UIButton()
    private let tableView = UITableView()

    init(viewModel: ProductSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        searchBar.placeholder = "Search products"
        view.addSubview(searchBar)

        categoryButton.setTitle("Category", for: .normal)
        categoryButton.backgroundColor = .systemGray5
        categoryButton.setTitleColor(.label, for: .normal)
        categoryButton.layer.cornerRadius = 8
        view.addSubview(categoryButton)

        brandButton.setTitle("Brand name", for: .normal)
        brandButton.backgroundColor = .systemGray5
        brandButton.setTitleColor(.label, for: .normal)
        brandButton.layer.cornerRadius = 8
        view.addSubview(brandButton)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
        view.addSubview(tableView)

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(16)
        }

        categoryButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(view.snp.width).multipliedBy(0.45)
        }

        brandButton.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(view.snp.width).multipliedBy(0.45)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(categoryButton.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview().inset(16)
        }
    }

    private func bindViewModel() {
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
    }

    private func showCategoryPicker() {
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
    }

    private func showBrandPicker() {
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
    }
}
