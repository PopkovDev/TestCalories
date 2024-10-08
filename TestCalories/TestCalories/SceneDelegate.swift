//
//  SceneDelegate.swift
//  TestCalories
//
//  Created by Андрей Попков on 08.10.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let productService = MockProductService()
        let productsViewModel = ProductsViewModel(productService: productService)
        let productsViewController = ProductsViewController(viewModel: productsViewModel)
        let navigationController = UINavigationController(rootViewController: productsViewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}


