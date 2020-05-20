//
//  MealsViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class MealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var meals: [Meal] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let repository = FirestoreRepository()
        repository.getAllMeals(success: { listMeals in
            self.meals = listMeals
            self.tableView.reloadData()
        }, failure: { error in
            
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as! MealTableViewCell
        let meal = meals[indexPath.row]
        cell.mealName.text = meal.name
        cell.mealDate.text = meal.date.toStringFormatted()
        return cell
    }
}

