//
//  ListViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 07/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        let repository = FirestoreRepository()
        repository.getAllMeals(success: { listMeal in
            self.meals = listMeal
            self.tableview.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "OldMealTableViewCell") as! OldMealTableViewCell
        var meal = meals[indexPath.row]
        cell.mealName.text = meal.name
        cell.mealDate.text = meal.date.toStringFormatted()
        return cell
    }
    
    
}
