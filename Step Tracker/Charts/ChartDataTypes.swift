//
//  ChartDataTypes.swift
//  Step Tracker
//
//  Created by Alexey Kremnev on 2/2/25.
//

import Foundation


struct WeekdayChartData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
