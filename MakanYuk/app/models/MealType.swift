//
//  MealType.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

enum MealType: String {
    case lunch = "lunch"
    case dinner = "dinner"
    case grignottage = "grignottage"
}

extension MealType {
    func toResponse() -> MealTypeResponse {
        switch self {
            case .lunch: return MealTypeResponse.lunch
            case .dinner: return MealTypeResponse.dinner
            case .grignottage: return MealTypeResponse.grignottage
        }
    }
}
