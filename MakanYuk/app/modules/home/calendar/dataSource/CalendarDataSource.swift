//
//  CalendarDataSource.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation
import JTAppleCalendar

class CalendarDataSource: JTACMonthViewDelegate, JTACMonthViewDataSource {
    var delegate: CalendarDataSourceDelegate?
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        guard let dayCell = cell as? DayCell else { return }
        dayCell.updateCellSelectionState(cellState: cellState, hasMeal: delegate?.hasMealAtDate(date: date))
    }
    
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.dayLabel.text = cellState.text
        cell.updateCellSelectionState(cellState: cellState, hasMeal: delegate?.hasMealAtDate(date: date))
        return cell
    }
    
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = Date()
        let endDate = Date().getNextMonthsDate()
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .off,
                                                 firstDayOfWeek: .monday,
                                                 hasStrictBoundaries: true)
        return parameters
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let dayCell = cell as? DayCell else { return }
        dayCell.updateCellSelectionState(cellState: cellState, hasMeal: delegate?.hasMealAtDate(date: date))
        delegate?.didSelectDay()
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        guard let dayCell = cell as? DayCell else { return }
        dayCell.updateCellSelectionState(cellState: cellState, hasMeal: delegate?.hasMealAtDate(date: date))
        delegate?.didSelectDay()
    }
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        guard let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "MonthHeaderView", for: indexPath) as? MonthHeaderView else { return JTACMonthReusableView() }
        let date = range.start
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        header.title.text = formatter.string(from: date)
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        MonthSize(defaultSize: 35)
    }
    
    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        //updateSelectedMonth(date: visibleDates.monthDates[8].date)
    }
}
