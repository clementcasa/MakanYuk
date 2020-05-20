//
//  Meal.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

struct Meal {
    let documentId: String?
    var name: String
    var date: Date
    var ingredients: [Ingredient]
    var type: MealType
}

extension Meal {
    func toResponse() -> MealResponse {
        MealResponse(
            documentId: documentId,
            name: name,
            date: date.toStringFormatted(),
            ingredients: ingredients.map { $0.toResponse() },
            type: type.toResponse()
        )
    }
}
