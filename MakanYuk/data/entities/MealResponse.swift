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
    let plate: PlateResponse
    let type: MealTypeResponse
    
    var data: [String: Any] {
        [
            "name": self.name,
            "date": self.date,
            "plate": self.plate.data,
            "mealType": self.type.rawValue
        ]
    }
    
    init(documentId: String? = nil, name: String, date: String, plate: PlateResponse, type: MealTypeResponse) {
        self.documentId = documentId
        self.name = name
        self.date = date
        self.plate = plate
        self.type = type
    }
    
    init(documentId: String? = nil, data: [String: Any]) {
        self.documentId = documentId
        self.name = data["name"] as? String ?? ""
        self.date = data["date"] as? String ?? ""
        self.plate = PlateResponse(data: data["plate"] as? [String: Any] ?? [:])
        self.type = MealTypeResponse(rawValue: data["mealType"] as? String ?? "") ?? MealTypeResponse.grignottage
    }
}

extension MealResponse {
    func toModel() -> Meal {
        Meal(documentId: documentId, name: name, date: date.toDate(), plate: plate.toModel(), type: type.toModel())
    }
}
