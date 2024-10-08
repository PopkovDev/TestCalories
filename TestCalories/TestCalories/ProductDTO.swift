//
//  ProductDTO.swift
//  TestCalories
//
//  Created by Levon Shaxbazyan on 08.10.24.
//

import Foundation

struct ProductDTO: Codable {
    let fdcId: Int
    let description: String
    let foodNutriants: [FoodNutriantsDTO]
}
