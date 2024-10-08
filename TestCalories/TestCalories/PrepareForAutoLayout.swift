//
//  PrepareForAutoLayout.swift
//  TestCalories
//
//  Created by Levon Shaxbazyan on 08.10.24.
//

import UIKit

public func prepareForAutoLayout<T: UIView>(_ view: T) -> T {
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
}
