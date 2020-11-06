//
//  MealsListViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

protocol MealsListDelegate {
    func onRefreshDataFromMeals()
    func onShowMealsDetails(meal: Meal)
}

class MealsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private let dataSource = MealsListDataSource()
    
    var delegate: MealsListDelegate?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
    }

    private func setupTableView() {
        dataSource.delegate = self
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func didPullToRefresh() {
        delegate?.onRefreshDataFromMeals()
    }
    
    func stopRefresh() {
        refreshControl.endRefreshing()
    }
    
    func updateData(meals: [Meal]) {
        if meals.isEmpty {
            tableView.isHidden = true
            emptyLabel.isHidden = false
            return
        }
        tableView.isHidden = false
        emptyLabel.isHidden = true
        dataSource.updateDatas(newMealsList: meals)
        tableView.reloadData()
    }
}

extension MealsListViewController: MealsListDataSourceDelegate {
    func onShowMealDetails(meal: Meal) {
        delegate?.onShowMealsDetails(meal: meal)
    }
}
