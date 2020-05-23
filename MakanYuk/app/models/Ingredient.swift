//
//  Ingredient.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

struct Ingredient {
    let name: String
    let quantity: String
    var isChecked: Bool
    
    init(name: String, quantity: String, isChecked: Bool = false) {
        self.name = name
        self.quantity = quantity
        self.isChecked = isChecked
    }
    
    mutating func setIsChecked(isChecked: Bool) {
        self.isChecked = isChecked
    }
}

extension Ingredient {
    func toResponse() -> IngredientResponse {
        IngredientResponse(name: name, quantity: quantity, isChecked: isChecked)
    }
}
