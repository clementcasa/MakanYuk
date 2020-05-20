//
//  Meal.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

struct MealResponse {
    let documentId: String?
    let name: String
    let date: String
    let ingredients: [IngredientResponse]
    let type: MealTypeResponse
    
    var data: [String: Any] {
        [
            "name": self.name,
            "date": self.date,
            "ingredients": self.ingredients.map { $0.data },
            "mealType": self.type.rawValue
        ]
    }
    
    init(documentId: String? = nil, name: String, date: String, ingredients: [IngredientResponse], type: MealTypeResponse) {
        self.documentId = documentId
        self.name = name
        self.date = date
        self.ingredients = ingredients
        self.type = type
    }
    
    init(documentId: String? = nil, data: [String: Any]) {
        self.documentId = documentId
        self.name = data["name"] as? String ?? ""
        self.date = data["date"] as? String ?? ""
        self.ingredients = (data["ingredients"] as? [[String: Any]])?.map { IngredientResponse(data: $0) } ?? []
        self.type = MealTypeResponse(rawValue: data["mealType"] as? String ?? "") ?? MealTypeResponse.grignottage
    }
}

extension MealResponse {
    func toModel() -> Meal {
        Meal(documentId: documentId, name: name, date: date.toDate(), ingredients: ingredients.map { $0.toModel() }, type: type.toModel())
    }
}
