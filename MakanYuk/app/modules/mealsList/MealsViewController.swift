//
//  MealsViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import JTAppleCalendar
import UIKit

class MealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var calendarView: JTACMonthView!
    @IBOutlet weak var selectedMonth: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyMealLabel: UILabel!
    
    private var repository: FirestoreRepository?
    
    var meals: [Meal] = []
    var selectedMeals: [Meal] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository = FirestoreRepository()

        setupTableView()
        setupCalendarView()
        
        calendarView.selectDates([Date()])
        updateSelectedMonth(date: Date())
        refreshData()
    }
    
    @objc private func didPullToRefresh() {
        refreshData()
    }
    
    func refreshData() {
        repository?.getAllMeals(success: { listMeals in
            self.meals = listMeals.sorted(by: { (meal1, meal2) -> Bool in meal1.date < meal2.date })
            self.updateSelectedMeals()
            self.calendarView.reloadData()
            self.refreshControl.endRefreshing()
        }, failure: { error in
            self.refreshControl.endRefreshing()
        })
    }
    
    func updateSelectedMeals() {
        var selectedDates = calendarView.selectedDates
        if selectedDates.isEmpty {
            selectedDates = [Date()]
        }
        self.selectedMeals = self.meals.filter { selectedDates.containsDate($0.date) }
        if self.selectedMeals.isEmpty {
            self.emptyMealLabel.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.emptyMealLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupCalendarView() {
        calendarView.calendarDelegate = self
        calendarView.calendarDataSource = self
        
        calendarView.allowsDateCellStretching = true
        calendarView.allowsMultipleSelection = true
        calendarView.cellSize = 50.0
        calendarView.minimumLineSpacing = 0.0
        calendarView.minimumInteritemSpacing = 0.0
        calendarView.scrollingMode = .stopAtEachSection
    }
    
    func updateSelectedMonth(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        let month = formatter.string(from: date)
        selectedMonth.text = "\(month)"
    }
    
    func hasMealAtDate(date: Date) -> Bool {
        meals.filter { $0.date.isSameDay(date: date) }.isEmpty == false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedMeals.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as! MealTableViewCell
        let meal = selectedMeals[indexPath.row]
        cell.mealName.text = meal.name
        cell.mealDate.text = meal.date.toStringFormatted()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = selectedMeals[indexPath.row]
        let viewController = storyboard!.instantiateViewController(withIdentifier: "MealViewController") as! MealViewController
        viewController.meal = meal
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func didTapOnNewMeal(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "MealViewController", sender: nil)
    }
    
    
    @IBAction func didTapOnShowIngredients(_ sender: UIBarButtonItem) {
        let viewController = storyboard! .instantiateViewController(withIdentifier: "ListOfIngredientsViewController") as! ListOfIngredientsViewController
        viewController.meals = selectedMeals
        present(viewController, animated: true)
    }
}


//CalendarView code
extension MealsViewController : JTACMonthViewDelegate, JTACMonthViewDataSource {
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let dayCell = cell as? DayCell else { return }
        dayCell.updateCellSelectionState(cellState: cellState, hasMeal: hasMealAtDate(date: date))
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.dayLabel.text = cellState.text
        cell.updateCellSelectionState(cellState: cellState, hasMeal: hasMealAtDate(date: date))
        return cell
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = Date()
        let endDate = Date().getNextMonthsDate()
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true)
        return parameters
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let dayCell = cell as? DayCell else { return }
        dayCell.updateCellSelectionState(cellState: cellState, hasMeal: hasMealAtDate(date: date))
        updateSelectedMeals()
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let dayCell = cell as? DayCell else { return }
        dayCell.updateCellSelectionState(cellState: cellState, hasMeal: hasMealAtDate(date: date))
        updateSelectedMeals()
    }
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        updateSelectedMonth(date: visibleDates.monthDates[8].date)
    }
}
