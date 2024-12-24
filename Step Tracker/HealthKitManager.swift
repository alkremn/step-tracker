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
    
    var stepData: [HealthMetric] = []
    var weightData: [HealthMetric] = []
    
    func fetchStepCount() async {
        let today = Calendar.current.startOfDay(for: .now)
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let startDate = Calendar.current.date(byAdding: .day, value: -28, to: endDate)!
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.stepCount), predicate: queryPredicate)
        let sumsOfStepsQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate,
            options: .cumulativeSum,
            anchorDate: endDate,
            intervalComponents: .init(day: 1)
        )
        
        let stepsCount = try! await sumsOfStepsQuery.result(for: store)
        stepData = stepsCount.statistics().map {
            .init(date: $0.startDate, value: $0.sumQuantity()?.doubleValue(for: .count()) ?? 0)
        }
    }
    
    func fetchWeight() async {
        let today = Calendar.current.startOfDay(for: .now)
        let endDate = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let startDate = Calendar.current.date(byAdding: .day, value: -28, to: endDate)!
        
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let samplePredicate = HKSamplePredicate.quantitySample(type: HKQuantityType(.bodyMass), predicate: queryPredicate)
        let weightQuery = HKStatisticsCollectionQueryDescriptor(
            predicate: samplePredicate,
            options: .mostRecent,
            anchorDate: endDate,
            intervalComponents: .init(day: 1)
        )
        
        let weights = try! await weightQuery.result(for: store)
        
        weightData = weights.statistics().map {
            .init(date: $0.startDate, value: $0.mostRecentQuantity()?.doubleValue(for: .pound()) ?? 0)
        }
    }
    
//    func addSeedData() async {
//        var seedData: [HKQuantitySample] = []
//        
//        for i in 0..<28 {
//            let stepQuantity = HKQuantity(unit: .count(), doubleValue: .random(in: 4_000...20_000))
//            let weightQuantity = HKQuantity(unit: .pound(), doubleValue: .random(in: (160 + Double(i/3)...165 + Double(i/3))))
//            
//            let startDate = Calendar.current.date(byAdding: .day, value: -i, to: .now)!
//            let endDate = Calendar.current.date(byAdding: .second, value: 1, to: startDate)!
//            
//            let stepSample = HKQuantitySample(type: HKQuantityType(.stepCount), quantity: stepQuantity, start: startDate, end: endDate)
//            let weightSample = HKQuantitySample(type: HKQuantityType(.bodyMass), quantity: weightQuantity, start: startDate, end: endDate)
//            
//            seedData.append(stepSample)
//            seedData.append(weightSample)
//        }
//        
//        try! await store.save(seedData)
//        print("✅ Dummy Data sent up")
//    }
}
