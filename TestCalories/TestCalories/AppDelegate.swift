//
//  AppDelegate.swift
//  TestCalories
//
//  Created by Андрей Попков on 08.10.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let productService = MockProductService()
        let productsViewModel = ProductsViewModel(productService: productService)
        let productsViewController = ProductsViewController(viewModel: productsViewModel)
        let navigationController = UINavigationController(rootViewController: productsViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

