//
//  MealTableViewCell.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var mealDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true
    }
    
    override func setHighlighted(_ highlighted: Bool, animated _: Bool) {
        UIView.animate(withDuration: 0.25) {
            if highlighted {
                self.containerView.backgroundColor = UIColor.lightGray
            } else {
                self.containerView.backgroundColor = UIColor.systemIndigo
            }
        }
    }
    
    func onBind(meal: Meal) {
        mealName.text = meal.name
        mealTypeLabel.text = meal.type.rawValue
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        mealDate.text = formatter.string(from: meal.date)
    }
}
