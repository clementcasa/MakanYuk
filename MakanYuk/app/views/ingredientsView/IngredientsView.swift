//
//  IngredientsView.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 22/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

@IBDesignable
class IngredientsView: UIView {
    
    @IBOutlet private var containerView: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var newIngredientTextField: UITextField!
    @IBOutlet weak var newQuantityTextField: UITextField!
    @IBOutlet weak var newIngredientButton: UIButton!

    @IBOutlet weak var addIngredientsViewContainer: UIView!
    @IBOutlet weak var addIngredientsViewHeightConstraint: NSLayoutConstraint!
    
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
    
    func setupWithData(ingredients: [Ingredient]) {
        ingredients.forEach { addIngredient(ingredientItem: $0) }
    }
    
    func hideAddNewIngrdient() {
        addIngredientsViewContainer.isHidden = true
        addIngredientsViewHeightConstraint.constant = 0.0
        layoutIfNeeded()
    }
    
    private func addIngredient(ingredientItem: Ingredient) {
        let ingredientView = IngredientView(
            frame: CGRect(x: 0.0, y: 0.0, width: stackView.frame.width, height: 62.0)
        )
        ingredientView.setupData(ingredient: ingredientItem)
        stackView.addArrangedSubview(ingredientView)
    }
    
    func getIngredientsList() -> [Ingredient] {
        stackView.subviews.map {
            ($0 as? IngredientView)?.ingredient ?? Ingredient(name: "", quantity: "")
        }.filter { $0.name != "" }
    }
    
    @IBAction func didTapOnAddNewIngredient(_ sender: UIButton) {
        guard let ingredient = newIngredientTextField.text,
            let quantity = newQuantityTextField.text,
            ingredient.count > 3,
            quantity.count > 0 else { return }
        addIngredient(ingredientItem: Ingredient(name: ingredient, quantity: quantity))
        newIngredientTextField.text = nil
        newQuantityTextField.text = nil
    }
}
