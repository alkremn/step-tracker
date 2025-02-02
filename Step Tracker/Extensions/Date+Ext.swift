//
//  Date+Ext.swift
//  Step Tracker
//
//  Created by Alexey Kremnev on 2/2/25.
//

import Foundation


extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
}
