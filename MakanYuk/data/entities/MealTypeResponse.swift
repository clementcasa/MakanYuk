//
//  MealTypeResponse.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

enum MealTypeResponse: String {
    case lunch = "lunch"
    case dinner = "dinner"
    case grignottage = "grignottage"
}

extension MealTypeResponse {
    func toModel() -> MealType {
        switch self {
            case .lunch: return MealType.lunch
            case .dinner: return MealType.dinner
            case .grignottage: return MealType.grignottage
        }
    }
}
