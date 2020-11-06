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
    var plate: Plate
    var type: MealType
    
    init(name: String, date: Date, plate: Plate, type: MealType) {
        self.documentId = nil
        self.name = name
        self.date = date
        self.plate = plate
        self.type = type
    }
    
    init(documentId: String?, name: String, date: Date, plate: Plate, type: MealType) {
        self.documentId = documentId
        self.name = name
        self.date = date
        self.plate = plate
        self.type = type
    }
    
    func getIngredients() -> [Ingredient] {
        plate.ingredients
    }
}

extension Meal {
    func toResponse() -> MealResponse {
        MealResponse(
            documentId: documentId,
            name: name,
            date: date.toStringFormatted(),
            plate: plate.toResponse(),
            type: type.toResponse()
        )
    }
}
