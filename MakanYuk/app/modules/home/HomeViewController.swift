//
//  MealsViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import JTAppleCalendar
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var calendarViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedMonth: UILabel!
    @IBOutlet weak var calendarWeekStackView: UIStackView!
    @IBOutlet weak var calendarView: JTACMonthView!
    
    private let calendarDataSource = CalendarDataSource()
    
    @IBOutlet weak var listSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pageViewContainer: UIView!
    
    private var repository: FirestoreRepository?
    
    var meals: [Meal] = []
    var selectedMeals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository = FirestoreRepository()

        setupCalendarView()
        setupLists()
        
        (children.first as? HomePageViewController)?.setSecondVCVisible()
        (children.first as? HomePageViewController)?.setFirstVCVisible()
        calendarView.selectDates([Date()])
        refreshData()
        //refreshDataDebug()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarContainerView.layer.cornerRadius = 8
        calendarContainerView.clipsToBounds = true
    }
    
    func setupCalendarView() {
        calendarDataSource.delegate = self
        calendarView.calendarDelegate = calendarDataSource
        calendarView.calendarDataSource = calendarDataSource
        
        calendarView.allowsDateCellStretching = true
        calendarView.allowsMultipleSelection = true
        calendarView.cellSize = 50.0
        calendarView.minimumLineSpacing = 0.0
        calendarView.minimumInteritemSpacing = 0.0
        calendarView.scrollingMode = .stopAtEachSection
    }
    
    func setupLists() {
        (children.first as? HomePageViewController)?.mealsVC?.delegate = self
        (children.first as? HomePageViewController)?.groceriesVC?.delegate = self
    }
    
    func refreshData() {
        repository?.getAllMeals(success: { listMeals in
            self.meals = listMeals.sorted(by: { (meal1, meal2) -> Bool in meal1.date < meal2.date })
            self.updateSelectedMeals()
            self.calendarView.reloadData()
        }, failure: { error in })
    }
    
    func refreshDataDebug() {
        self.meals = [
            Meal(
                name: "Meal",
                date: Date(),
                plate: Plate(
                    name: "Plate", ingredients: [
                        Ingredient(name: "Ingredient", quantity: "1")
                    ]),
                type: .lunch
            ),
            Meal(
                name: "Meal",
                date: Date(),
                plate: Plate(
                    name: "Plate", ingredients: [
                        Ingredient(name: "Ingredient", quantity: "1")
                    ]),
                type: .lunch
            ),
            Meal(
                name: "Meal",
                date: Date(),
                plate: Plate(
                    name: "Plate", ingredients: [
                        Ingredient(name: "Ingredient", quantity: "1")
                    ]),
                type: .lunch
            )
        ]
        self.updateSelectedMeals()
        self.calendarView.reloadData()
    }
    
    func updateSelectedMeals() {
        var selectedDates = calendarView.selectedDates
        if selectedDates.isEmpty {
            selectedDates = [Date()]
        }
        selectedMeals = self.meals.filter { selectedDates.containsDate($0.date) }
        var ingredients: [Ingredient] = []
        selectedMeals.forEach { ingredients.append(contentsOf: $0.getIngredients()) }
        (children.first as? HomePageViewController)?.mealsVC?.updateData(meals: selectedMeals)
        (children.first as? HomePageViewController)?.groceriesVC?.updateData(ingredients: ingredients)
    }
    
    func updateMonthLabel() {
        let selectedDates = calendarView.selectedDates
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        if selectedDates.count == 0 {
            selectedMonth.text = "Select a date"
        } else if selectedDates.count == 1 {
            selectedMonth.text = formatter.string(from: selectedDates.first ?? Date())
        } else {
            var str = formatter.string(from: selectedDates.first ?? Date())
            str = str + " - "
            str = str + formatter.string(from: selectedDates.last ?? Date())
            selectedMonth.text = str
        }
    }

    @IBAction func didTapOnToggleCalendar(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.calendarView.isHidden = !self.calendarView.isHidden
            self.calendarWeekStackView.isHidden = !self.calendarWeekStackView.isHidden
            if self.calendarView.isHidden {
                self.calendarViewHeightConstraint.constant = 45
            } else {
                self.calendarViewHeightConstraint.constant = 420
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func didTapOnNewMeal(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "MealViewController", sender: nil)
    }
    
    @IBAction func didToggleSegmentedControlForList(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0 : (children.first as? HomePageViewController)?.setFirstVCVisible()
            case 1 : (children.first as? HomePageViewController)?.setSecondVCVisible()
            default: ()
        }
    }
    
    @IBAction func didTapOnShowIngredients(_ sender: UIBarButtonItem) {
        let viewController = storyboard! .instantiateViewController(withIdentifier: "ListOfIngredientsViewController") as! ListOfIngredientsViewController
        viewController.meals = selectedMeals
        present(viewController, animated: true)
    }
}

extension HomeViewController: CalendarDataSourceDelegate {
    func didSelectDay() {
        updateSelectedMeals()
        updateMonthLabel()
    }
    
    func hasMealAtDate(date: Date) -> Bool {
        meals.filter { $0.date.isSameDay(date: date) }.isEmpty == false
    }
}

extension HomeViewController: MealsListDelegate {
    func onRefreshDataFromMeals() {
        
    }
    
    func onShowMealsDetails(meal: Meal) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MealViewController") as? MealViewController {
            vc.meal = meal
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: GroceriesListDelegate {
    func onRefreshDataFromGroceries() {
        
    }
    
    func onShowGroceriesListView() {
        
    }
}
