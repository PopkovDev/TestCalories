//
//  ProductsView.swift
//  TestCalories
//
//  Created by Levon Shaxbazyan on 08.10.24.
//

import UIKit

class ProductsView: UIView {
    
    // MARK: - Constants
    
    enum Constants {
        enum Insets {
            static let top: CGFloat = 20
            static let leading: CGFloat = 16
            static let trailing: CGFloat = -16
            static let smallSpacing: CGFloat = 8
            static let stackViewSpacing: CGFloat = 12
            static let buttonHeight: CGFloat = 32
            static let pickerHeight: CGFloat = 44
            static let searchBarHeight: CGFloat = 44
            static let collectionViewTop: CGFloat = 16
        }
        enum Texts {
            static let titleLabel = "Breakfast"
            static let brandNamePlaceholder = "Brand name"
            static let categoryPlaceholder = "Category"
        }
    }
    
    // MARK: - Visual Components
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.titleLabel
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let productSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .subViewsBackground
        searchBar.placeholder = "Search for products"
        return searchBar
    }()
    
    let brandNamePickerButon: UIButton = {
        let button = UIButton()
        button.backgroundColor = .subViewsBackground
        return button
    }()
    
    let categoryPickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .subViewsBackground
        return button
    }()
    
    let filtersStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.Insets.stackViewSpacing
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .background
        return stackView
    }()
    
    let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero, collectionViewLayout: layout
        )
        collectionView.backgroundColor = .clear
        collectionView.register(
            ProductCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        configureConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupSubviews() {
        addSubviews([
            titleLabel,
            productSearchBar,
            filtersStackView,
            productsCollectionView
        ])
        
        filtersStackView.addArrangedSubviews([
            brandNamePickerButon,
            categoryPickerButton
        ])
        backgroundColor = .background
    }
    
    private func configureConstraints() {
        configureTitleLabelConstraints()
        configureSearchBarConstraints()
        configureFiltersStackViewConstraints()
        configureCollectionViewConstraints()
    }    
   
}

extension ProductsView {
    private func configureTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.Insets.top),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.leading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Insets.trailing)
        ])
    }
    
    private func configureSearchBarConstraints() {
        NSLayoutConstraint.activate([
            productSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Insets.smallSpacing),
            productSearchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.leading),
            productSearchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Insets.trailing),
            productSearchBar.heightAnchor.constraint(equalToConstant: Constants.Insets.searchBarHeight)
        ])
    }
    
    private func configureFiltersStackViewConstraints() {
        NSLayoutConstraint.activate([
            filtersStackView.topAnchor.constraint(equalTo: productSearchBar.bottomAnchor, constant: Constants.Insets.smallSpacing),
            filtersStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.leading),
            filtersStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Insets.trailing),
            filtersStackView.heightAnchor.constraint(equalToConstant: Constants.Insets.buttonHeight)
        ])
    }
    
    private func configureCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: filtersStackView.bottomAnchor, constant: Constants.Insets.collectionViewTop),
            productsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Insets.leading),
            productsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Insets.trailing),
            productsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
