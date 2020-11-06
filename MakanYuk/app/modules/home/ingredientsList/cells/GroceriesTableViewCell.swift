//
//  GroceriesTableViewCell.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class GroceriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    func onBind(ingredient: Ingredient) {
        titleLabel.text = ingredient.name
        detailsLabel.text = ingredient.quantity
    }
}
