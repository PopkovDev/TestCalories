//
//  ProductService.swift
//  TestCalories
//
//  Created by Андрей Попков on 08.10.2024.
//

import Foundation
import RxSwift

struct Product {
    let name: String
    let brand: String
    let category: String
    let calories: Int
}

protocol ProductServiceProtocol {
    func searchProducts(query: String, category: String?, brand: String?) -> Observable<[Product]>
    func fetchCategories() -> Observable<[String]>
    func fetchBrands() -> Observable<[String]>
}

class MockProductService: ProductServiceProtocol {
    
    private let mockProducts: [Product] = [
        Product(name: "Oatmeal with milk", brand: "PRIMA DONNA", category: "Porridge", calories: 119),
        Product(name: "Rice porridge with abalone", brand: "QUESOS LA RICURA LTD.", category: "Porridge", calories: 290),
        Product(name: "Cornmeal porridge", brand: "SARTORI", category: "Porridge", calories: 210),
        Product(name: "Rice porridge with milk", brand: "CITRUS GINGER BELLAVITANO", category: "Porridge", calories: 209),
        Product(name: "Porridge oats with milk", brand: "KOOL TART", category: "Porridge", calories: 570),
        Product(name: "Rice porridge with milk", brand: "MIFROMA", category: "Porridge", calories: 570),
        Product(name: "Cornmeal porridge", brand: "SAPORI DI CASA", category: "Porridge", calories: 570)
    ]
    
    func searchProducts(query: String, category: String?, brand: String?) -> Observable<[Product]> {
        let filteredProducts = mockProducts.filter { product in
            let matchesQuery = product.name.lowercased().contains(query.lowercased()) || query.isEmpty
            let matchesCategory = (category == nil || product.category == category)
            let matchesBrand = (brand == nil || product.brand == brand)
            return matchesQuery && matchesCategory && matchesBrand
        }
        return Observable.just(filteredProducts)
    }
    
    func fetchCategories() -> Observable<[String]> {
        return Observable.just(["Porridge", "Cookies", "Fish", "Candy", "Fruit", "Vegetable", "Pizza"])
    }
    
    func fetchBrands() -> Observable<[String]> {
        return Observable.just(["PRIMA DONNA", "QUESOS LA RICURA LTD.", "SARTORI", "CITRUS GINGER BELLAVITANO", "KOOL TART", "MIFROMA", "SAPORI DI CASA"])
    }
}
