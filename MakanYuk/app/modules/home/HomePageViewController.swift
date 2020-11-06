//
//  HomePageViewController.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class HomePageViewController: UIPageViewController {
    
    var mealsVC: MealsListViewController?
    var groceriesVC: GroceriesListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        mealsVC = storyboard?.instantiateViewController(withIdentifier: "MealsListViewController")
            as? MealsListViewController
        groceriesVC = storyboard?.instantiateViewController(withIdentifier: "GroceriesListViewController")
            as? GroceriesListViewController
        guard let mealsVC = mealsVC else { return }
        setViewControllers([mealsVC], direction: .forward, animated: true) { completed in
            
        }
    }
    
    func setFirstVCVisible() {
        guard let vc = mealsVC else { return }
        setViewControllers([vc], direction: .reverse, animated: true) { completed in
            
        }
    }

    func setSecondVCVisible() {
        guard let vc = groceriesVC else { return }
        setViewControllers([vc], direction: .forward, animated: true) { completed in
            
        }
    }
}
