//
//  CalendarDataSourceDelegate.swift
//  MakanYuk
//
//  Created by Clément Casamayou on 06/11/2020.
//  Copyright © 2020 ClemHilmy. All rights reserved.
//

import Foundation

protocol CalendarDataSourceDelegate: AnyObject {
    func didSelectDay()
    func hasMealAtDate(date: Date) -> Bool
}
