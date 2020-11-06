//
//  MealsListDataSourceDelegate.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

protocol MealsListDataSourceDelegate: AnyObject {
    func onShowMealDetails(meal: Meal)
}
