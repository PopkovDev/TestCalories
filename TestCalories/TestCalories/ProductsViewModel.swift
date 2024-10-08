//
//  ProductsViewModel.swift
//  TestCalories
//
//  Created by Андрей Попков on 08.10.2024.
//

import Foundation
import RxSwift
import RxCocoa

final class ProductsViewModel {
    
    let query = BehaviorRelay<String>(value: "")
    let selectedCategory = BehaviorRelay<String?>(value: nil)
    let selectedBrand = BehaviorRelay<String?>(value: nil)
    
    let products: Observable<[Product]>
    let categories: Observable<[String]>
    let brands: Observable<[String]>
    
    private let productService: ProductServiceProtocol
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers

    init(productService: ProductServiceProtocol) {
        self.productService = productService
        
        products = Observable.combineLatest(query, selectedCategory, selectedBrand)
            .flatMapLatest { query, category, brand in
                return productService.searchProducts(query: query, category: category, brand: brand)
            }
            .share(replay: 1)
        
        categories = productService.fetchCategories()
        brands = productService.fetchBrands()
    }
    
    func fetchProducts() {
        NetworkService.shared.sendRequest(
            baseURL: .baseUrl,
            query: .foodsList,
            httpMethod: .get,
            parameters: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("JSON String for orders: \(jsonString)")
                        }
                        let model = try JSONDecoder()
                            .decode(SingleOrder.self, from: data)
                        
                        
                    } catch {
                        self.handleDecodingError(error)
                    }
                case .failure(let error):
                    if let networkError = error as? NetworkError,
                       networkError == .notModified {
                        DispatchQueue.main.async { [weak self] in
                            guard let self else { return }
                            self.loadingIndicator.stopAnimating()
                            self.showAlertForNotModifiedAdmin()
                        }
                    } else {
                        print(error.localizedDescription)
                    }
                }
            }
    }
    
    func filterProductsByCategory(_ category: String) {
        selectedCategory.accept(category)
    }
    
    func filterProductsByBrand(_ brand: String) {
        selectedBrand.accept(brand)
    }
    
    private func handleDecodingError(_ error: Error) {
        switch error {
        case DecodingError.keyNotFound(let key, let context):
            print("Decoding error (keyNotFound): \(key) not found in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        case DecodingError.dataCorrupted(let context):
            print("Decoding error (dataCorrupted): data corrupted in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        case DecodingError.typeMismatch(let type, let context):
            print("Decoding error (typeMismatch): type mismatch of \(type) in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        case DecodingError.valueNotFound(let type, let context):
            print("Decoding error (valueNotFound): value not found for \(type) in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        default:
            print(error.localizedDescription)
        }
    }
}
