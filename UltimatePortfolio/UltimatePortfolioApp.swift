//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by Kelsey Garcia on 1/6/21.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        // _dataController refers to the State Object referring to the DataController
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // For SwiftUI to read Core Data values
                .environment(\.managedObjectContext, dataController.container.viewContext)
                // For our code to read Core Data values
                .environmentObject(dataController)
                // Save data when app moves to background
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: save)
        }
    }
    
    func save(_ note: Notification) {
        dataController.save()
    }
}
