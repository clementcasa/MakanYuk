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
    
    var data: [String: Any] {
        [
            "name": self.name,
            "quantity": self.quantity
        ]
    }
    
    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
    }
    
    init(data: [String: Any]) {
        self.name = data["name"] as? String ?? ""
        self.quantity = data["quantity"] as? String ?? ""
    }
    
    mutating func incrementQuantity(quantity: String) {
        self.quantity = "\(self.quantity) + \(quantity)"
    }
}

extension IngredientResponse {
    func toModel() -> Ingredient {
        Ingredient(name: name, quantity: quantity)
    }
}
