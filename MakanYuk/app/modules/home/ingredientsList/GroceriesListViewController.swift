//
//  GroceriesListViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

protocol GroceriesListDelegate {
    func onRefreshDataFromGroceries()
    func onShowGroceriesListView()
}

class GroceriesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    
    private let dataSource = GroceriesListDataSource()
    
    var delegate: GroceriesListDelegate?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func didPullToRefresh() {
        delegate?.onRefreshDataFromGroceries()
    }
    
    func updateData(ingredients: [Ingredient]) {
        if ingredients.isEmpty {
            tableView.isHidden = true
            emptyLabel.isHidden = false
            return
        }
        dataSource.updateDatas(newIngredientsList: ingredients)
        tableView.reloadData()
    }
    
    func stopRefresh() {
        refreshControl.endRefreshing()
    }

    @IBAction func didTapOnMakeGroceries(_ sender: UIButton) {
        delegate?.onShowGroceriesListView()
    }
}
