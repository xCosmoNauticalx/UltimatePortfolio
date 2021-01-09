//
//  AwardsView.swift
//  UltimatePortfolio
//
//  Created by Kelsey Garcia on 1/9/21.
//

import SwiftUI

struct AwardsView: View {
    static let tag: String? = "Awards"
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Award.allAwards) { award in
                        Button {
                            // no action yet
                        } label: {
                            Image(systemName: award.image)
                                .resizable()
                                .scaledToFit()
                                .padding()
                                .frame(width: 100, height: 100)
                                .foregroundColor(Color.secondary.opacity(0.5))
                        } // end Button
                    } // end ForEach
                } // end LazyVGrid
            } // end ScrollView
            .navigationTitle("Awards")
        } // end NavigationView
    }
    
    var columns: [GridItem] {
        [GridItem(.adaptive(minimum: 100, maximum: 100))]
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
    }
}
