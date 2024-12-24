//
//  Step_TrackerApp.swift
//  Step Tracker
//
//  Created by Alexey Kremnev on 12/4/24.
//

import SwiftUI

@main
struct Step_TrackerApp: App {
    
    let hkManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(hkManager)
        }
    }
}
