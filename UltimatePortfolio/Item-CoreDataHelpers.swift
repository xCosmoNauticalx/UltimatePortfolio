//
//  Item-CoreDataHelpers.swift
//  UltimatePortfolio
//
//  Created by Kelsey Garcia on 1/6/21.
// Helper wrapper to interact with Core Data to eliminate the optional problem

import Foundation

extension Item {
    var itemTitle: String {
        title ?? ""
    }
    
    var itemDetail: String {
        detail ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    /// For SwiftUI previewing purposes
    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let item = Item(context: viewContext)
        item.title = "Example Item"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()
        return item
    }
}


