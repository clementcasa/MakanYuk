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
}

extension Ingredient {
    func toResponse() -> IngredientResponse {
        IngredientResponse(name: name, quantity: quantity)
    }
}
