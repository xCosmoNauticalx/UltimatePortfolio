//
//  DataController.swift
//  UltimatePortfolio
//
//  Created by Kelsey Garcia on 1/6/21.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        // Creates data store in RAM instead of on disk
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Load the underlying database if not in memory
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    /// Create preview data controller with sample data for SwiftUI previews
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        let viewContext = dataController.container.viewContext
        
        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }
        
        return dataController
    }()
    
    /// Create sample data for previews
    func createSampleData() throws {
        let viewContext = container.viewContext
        
        for i in 1...5 {
            let project = Project(context: viewContext)
            project.title = "Project \(i)"
            project.items = []
            project.creationDate = Date()
            project.closed = Bool.random()
            
            for j in 1...10 {
                let item = Item(context: viewContext)
                item.title = "Item \(j)"
                item.creationDate = Date()
                item.completed = Bool.random()
                item.project = project
                item.priority = Int16.random(in: 1...3)
            }
        }
        
        try viewContext.save()
    }
    
    /// Save changes
    func save () {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    /// Delete
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
    }
    
    /// Delete all (for testing purposes)
    func deleteAll() {
        // Find all items
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        // Convert to delete request
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        // Run delete request
        _ = try? container.viewContext.execute(batchDeleteRequest1)
        
        // Find all projects
        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
        // Convert to delete request
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        // Run delete request
        _ = try? container.viewContext.execute(batchDeleteRequest2)
    }
    
    /// Count # of something in Core Data and wrap so optional is handled
    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }
    
    /// Determine if user has earned an award
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "items":
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
            
        case "complete":
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            fetchRequest.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
            
        default:
            // fatalError("Unknown award criterion \(award.criterion).")
            return false
        }
    }
}

