//
//  DatePicker.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 22/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

@IBDesignable
class MealTypePicker: UITextField {
    
    private var picker: UIPickerView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        delegate = self
        picker = UIPickerView()
        picker?.delegate = self
        picker?.dataSource = self
        picker?.tintColor = UIColor.black
        picker?.backgroundColor = UIColor.white
        inputView = picker
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setMealType(mealType: MealType) {
        let row = MealType.allCases.firstIndex(of: mealType) ?? 0
        picker?.selectRow(row, inComponent: 0, animated: false)
        text = MealType.allCases[row].rawValue
    }
    
    func getMealType() -> MealType {
        MealType.allCases[picker?.selectedRow(inComponent: 0) ?? 0]
    }
}

extension MealTypePicker: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        text = MealType.allCases[picker?.selectedRow(inComponent: 0) ?? 0].rawValue
    }
}

extension MealTypePicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        MealType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        MealType.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = MealType.allCases[row].rawValue
    }
}
