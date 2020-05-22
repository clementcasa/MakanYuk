//
//  DatePicker.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 22/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import UIKit

@IBDesignable
class DatePicker: UITextField {
 
    private var picker: UIDatePicker?
    
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
        picker = UIDatePicker()
        picker?.calendar = Calendar.current
        picker?.date = Date()
        picker?.datePickerMode = .date
        picker?.locale = Locale.init(identifier: "fr-FR")
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
    
    func getSelectedDate() -> Date {
        return picker?.date ?? Date()
    }
    
    func setSelectedDate(date: Date) {
        picker?.date = date
        setDateLabel(date: date)
    }
    
    private func setDateLabel(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Locale.init(identifier: "fr-FR")
        text = formatter.string(from: date)
    }
}

extension DatePicker: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setDateLabel(date: picker?.date ?? Date())
    }
}
