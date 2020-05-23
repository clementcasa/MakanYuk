//
//  DateExtensions.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 16/05/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

extension Date {
    static func createDateWith(day: Int, month: Int, year: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        return Calendar.current.date(from: dateComponents)!
    }
    
    func getNextMonthsDate() -> Date {
        Calendar.current.date(byAdding: .month, value: 2, to: self) ?? Date()
    }
    
    func isSameDay(date: Date) -> Bool {
        let dateComponent = Calendar.current.dateComponents([.year, .day, .month], from: date)
        let baseDateComponent = Calendar.current.dateComponents([.year, .day, .month], from: self)
        return dateComponent.day == baseDateComponent.day &&
            dateComponent.month == baseDateComponent.month &&
            dateComponent.year == baseDateComponent.year
    }
    
    func toStringFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
}

extension Array where Element == Date {
    func containsDate(_ date: Date) -> Bool {
        contains { $0.isSameDay(date: date) }
    }
}

extension String {
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
}
