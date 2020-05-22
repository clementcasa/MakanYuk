//
//  IngredientView.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 22/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

class IngredientView: UIView {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var ingredient: Ingredient?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    private func setup() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]
        addSubview(containerView)
    }
    
    func setupData(ingredient: Ingredient) {
        self.ingredient = ingredient
        ingredientLabel.text = ingredient.name
        quantityLabel.text = ingredient.quantity
    }

    @IBAction func didTapOnDeleteButton(_ sender: UIButton) {
        removeFromSuperview()
    }
}
