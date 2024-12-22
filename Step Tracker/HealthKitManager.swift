//
//  HealthKitManager.swift
//  Step Tracker
//
//  Created by Alexey Kremnev on 12/19/24.
//

import Foundation
import HealthKit
import Observation


@Observable class HealthKitManager {

    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
