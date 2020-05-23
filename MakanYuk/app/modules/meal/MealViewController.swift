//
//  ListViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 07/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: DatePicker!
    @IBOutlet weak var mealTypeTextField: MealTypePicker!
    @IBOutlet weak var ingredientsView: IngredientsView!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = meal {
            nameTextField.text = meal.name
            dateTextField.setSelectedDate(date: meal.date)
            mealTypeTextField.setMealType(mealType: meal.type)
            ingredientsView.setupWithData(ingredients: meal.ingredients)
        }
    }
    
    @IBAction func didTapOnValidateButton(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        let date = dateTextField.getSelectedDate()
        let ingredients = ingredientsView.getIngredientsList()
        let mealType = mealTypeTextField.getMealType()
        
        var newMeal: Meal?
        if let meal = meal {
            newMeal = meal
            newMeal?.name = name
            newMeal?.date = date
            newMeal?.ingredients = ingredients
            newMeal?.type = mealType
        } else {
            newMeal = Meal(name: name, date: date, ingredients: ingredients, type: mealType)
        }
        
        let repository = FirestoreRepository()
        repository.updateOrCreateMeal(newMeal!, success: {
            self.navigationController?.dismiss(animated: true)
        }, failure: { error in
            
        })
    }
}
