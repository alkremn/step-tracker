//
//  HealthMetric.swift
//  Step Tracker
//
//  Created by Alexey Kremnev on 12/24/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}
