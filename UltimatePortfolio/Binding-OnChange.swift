//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Kelsey Garcia on 1/7/21.
//

import Foundation
import SwiftUI

extension Binding {
    /// Returns a new instance of Binding that uses the same type of data as the original Binding.
    ///     Takes an escaping closure to be executed when a change finally happens
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
