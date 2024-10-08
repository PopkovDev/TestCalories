//
//  ProductSearchViewModel.swift
//  TestCalories
//
//  Created by Андрей Попков on 08.10.2024.
//

import Foundation
import RxSwift
import RxCocoa

class ProductSearchViewModel {
    
    let query = BehaviorRelay<String>(value: "")
    let selectedCategory = BehaviorRelay<String?>(value: nil)
    let selectedBrand = BehaviorRelay<String?>(value: nil)
    
    let products: Observable<[Product]>
    let categories: Observable<[String]>
    let brands: Observable<[String]>
    
    private let productService: ProductServiceProtocol
    private let disposeBag = DisposeBag()
    
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
    
    func filterProductsByCategory(_ category: String) {
        selectedCategory.accept(category)
    }
    
    func filterProductsByBrand(_ brand: String) {
        selectedBrand.accept(brand)
    }
}
