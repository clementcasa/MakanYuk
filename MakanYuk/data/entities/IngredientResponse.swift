//
//  Ingredient.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

struct IngredientResponse {
    let name: String
    var quantity: String
    var isChecked: Bool
    
    var data: [String: Any] {
        [
            "name": self.name,
            "quantity": self.quantity,
            "isChecked": self.isChecked
        ]
    }
    
    init(name: String, quantity: String, isChecked: Bool = false) {
        self.name = name
        self.quantity = quantity
        self.isChecked = isChecked
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.quantity = data["quantity"] as? String ?? ""
        self.isChecked = data["isChecked"] as? Bool ?? false
    }
    
    mutating func incrementQuantity(quantity: String) {
        self.quantity = "\(self.quantity) + \(quantity)"
    }
}

extension IngredientResponse {
    func toModel() -> Ingredient {
        Ingredient(name: name, quantity: quantity, isChecked: isChecked)
    }
}
