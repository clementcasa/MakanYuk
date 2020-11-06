//
//  Plate.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

struct Plate {
    let documentId: String?
    var name: String
    var ingredients: [Ingredient]
    
    init(name: String, ingredients: [Ingredient]) {
        self.documentId = nil
        self.name = name
        self.ingredients = ingredients
    }
    
    init(documentId: String?, name: String, ingredients: [Ingredient]) {
        self.documentId = documentId
        self.name = name
        self.ingredients = ingredients
    }
}

extension Plate {
    func toResponse() -> PlateResponse {
        PlateResponse(
            documentId: documentId,
            name: name,
            ingredients: ingredients.map { $0.toResponse() }
        )
    }
}
