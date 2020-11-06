//
//  PlateResponse.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

struct PlateResponse {
    let documentId: String?
    let name: String
    var ingredients: [IngredientResponse]
    
    var data: [String: Any] {
        [
            "name": self.name,
            "ingredients": self.ingredients.map { $0.data }
        ]
    }
    
    init(documentId: String? = nil, name: String, ingredients: [IngredientResponse]) {
        self.documentId = documentId
        self.name = name
        self.ingredients = ingredients
    }
    
    init(documentId: String? = nil, data: [String: Any]) {
        self.documentId = documentId
        self.name = data["name"] as? String ?? ""
        self.ingredients = (data["ingredients"] as? [[String: Any]])?.map { IngredientResponse(data: $0) } ?? []
    }
}

extension PlateResponse {
    func toModel() -> Plate {
        Plate(documentId: documentId, name: name, ingredients: ingredients.map { $0.toModel() })
    }
}
