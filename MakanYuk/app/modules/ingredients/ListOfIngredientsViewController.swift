//
//  ListOfIngredientsViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 29/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class ListOfIngredientsViewController : UIViewController {
   
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var meals: [Meal]?
    var ingredients: [Ingredient] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let meals = meals {
            for meal in meals {
                //ingredients.append(contentsOf: meal.ingredients)
            }
        }
    }
}

extension ListOfIngredientsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsTableViewCell") as! IngredientsTableViewCell
        let ingredient = ingredients [indexPath.row]
        cell.ingredientNameLabel.text = ingredient.name
        cell.ingredientQuantityLabel.text = ingredient.quantity
    
        return cell
    }
}

