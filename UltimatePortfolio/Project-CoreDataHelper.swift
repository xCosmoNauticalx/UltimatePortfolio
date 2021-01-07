//
//  Project-CoreDataHelper.swift
//  UltimatePortfolio
//
//  Created by Kelsey Garcia on 1/6/21.
//

import Foundation

extension Project {
    var projectTitle: String {
        title ?? "New Project"
    }
    
    var projectDetail: String {
        detail ?? ""
    }
    
    var projectColor: String {
        color ?? "Light Blue"
    }
    
    /// For SwiftUI preview purposes
    static var example: Project {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let project = Project(context: viewContext)
        project.title = "Example Project"
        project.detail = "This is an example project"
        project.closed = true
        project.creationDate = Date()
        return project
    }
    
    /// Wrap the relationship
    var projectItems: [Item] {
        let itemsArray = items?.allObjects as? [Item] ?? []
        return itemsArray.sorted { first, second in
            // Put completed items at end of list since we care about them less
            if first.completed == false {
                if second.completed == true {
                    return true
                }
            } else if first.completed == true {
                if second.completed == false {
                    return false
                }
            }
            
            // Put higher priority items before lower priority items
            if first.priority > second.priority {
                return true
            } else if first.priority < second.priority {
                return false
            }
            
            // Otherwise, sort using creation date
            return first.itemCreationDate < second.itemCreationDate
        }
    }
    
    /// Determine how much of project is completed
    var completionAmount: Double {
        let originalItems = items?.allObjects as? [Item] ?? []
        guard originalItems.isEmpty == false else {return 0}
        
        let completedItems = originalItems.filter(\.completed)
        return Double(completedItems.count) / Double(originalItems.count)
    }
}
