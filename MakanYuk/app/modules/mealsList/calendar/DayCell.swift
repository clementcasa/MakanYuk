//
//  DayCell.swift
//  Hipay
//
//  Created by Clément Casamayou on 18/02/2019.
//  Copyright © 2019 Hiway. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DayCell: JTACDayCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var hasMealView: UIView!
    
    private var date: Date = Date()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setDatas(date: Date) {
        self.date = date
    }
    
    func updateCellSelectionState(cellState: CellState, hasMeal: Bool) {
        switch cellState.dateBelongsTo {
            case .thisMonth:
                dayLabel.isHidden = false
                isUserInteractionEnabled = true
            default:
                dayLabel.isHidden = true
                isUserInteractionEnabled = false
        }
        if cellState.isSelected {
            selectedView.isHidden = false
        } else {
            selectedView.isHidden = true
        }
        if hasMeal {
            hasMealView.isHidden = false
        } else {
            hasMealView.isHidden = true
        }
    }
}
