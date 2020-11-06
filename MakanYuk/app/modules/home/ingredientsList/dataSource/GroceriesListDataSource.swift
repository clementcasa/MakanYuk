//
//  GroceriesListDataSource.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class GroceriesListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var ingredients: [Ingredient] = []
    
    func updateDatas(newIngredientsList: [Ingredient]) {
        self.ingredients = newIngredientsList
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroceriesTableViewCell")
                as? GroceriesTableViewCell else { return UITableViewCell() }
        cell.onBind(ingredient: ingredients[indexPath.row])
        return cell
    }
}
