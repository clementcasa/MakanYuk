//
//  MealsListDataSource.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class MealsListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var meals: [Meal] = []
    var delegate: MealsListDataSourceDelegate?
    
    func updateDatas(newMealsList: [Meal]) {
        self.meals = newMealsList
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell")
                as? MealTableViewCell else { return UITableViewCell() }
        cell.onBind(meal: meals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.onShowMealDetails(meal: meals[indexPath.row])
    }
}
