//
//  ProductCollectionViewCell.swift
//  TestCalories
//
//  Created by Levon Shaxbazyan on 08.10.24.
//

import UIKit


/// Переиспользуемая ячейка для показа продуктов
final class ProductCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    private enum Constants {
        enum Insets {
            static let smallHeight: CGFloat = 18
            static let bigHeight: CGFloat = 28
            static let inset: CGFloat = 3
            static let leading: CGFloat = 15
            static let trailing: CGFloat = -15
        }
    }
    
    // MARK: - Visual Components

    private let productNameLabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    let productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        
        return label
    }()
    
    // MARK: - Public Properties

    static let identifier = "ProductCollectionViewCell"

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        configureLayout()
        setupContentView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupSubviews() {
        contentView.addSubviews([
            productNameLabel,
            productDescriptionLabel
        ])
    }

    private func configureLayout() {
        configureProductNameLabelConstraints()
        configureProductDescriptionLabelConstraints()
    }

    private func setupContentView() {
        contentView.backgroundColor = .subViewsBackground
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 16
    }

    // MARK: - Configuration
    
    func configureWith(
        model: Product
    ) {
        productNameLabel.text = model.name
        productDescriptionLabel.text = "\(model.brand) - kcal: \(model.calories)"
    }
}

/// Pасширение для устоновки размеров и расположения элементов
extension ProductCollectionViewCell {
    private func configureProductNameLabelConstraints() {
        NSLayoutConstraint.activate([
            productNameLabel.bottomAnchor.constraint(
                equalTo: contentView.centerYAnchor,
                constant: -Constants.Insets.inset
            ),
            productNameLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Insets.leading
            ),
            productNameLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            productNameLabel.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 0.8
            ),
            productNameLabel.heightAnchor.constraint(
                equalToConstant: Constants.Insets.bigHeight
            )
        ])
    }

    private func configureProductDescriptionLabelConstraints() {

        NSLayoutConstraint.activate([
            productDescriptionLabel.topAnchor.constraint(
                equalTo: contentView.centerYAnchor,
                constant: Constants.Insets.inset
            ),
            productDescriptionLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Insets.leading
            ),
            productDescriptionLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constants.Insets.trailing
            ),
            productDescriptionLabel.widthAnchor.constraint(
                equalTo: widthAnchor,
                multiplier: 0.8
            ),
            productDescriptionLabel.heightAnchor.constraint(
                equalToConstant: Constants.Insets.smallHeight
            )
        ])
    }
    
}
