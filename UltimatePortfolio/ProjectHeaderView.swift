//
//  ProjectHeaderView.swift
//  UltimatePortfolio
//
//  Created by Kelsey Garcia on 1/7/21.
//

import SwiftUI

struct ProjectHeaderView: View {
    @ObservedObject var project: Project
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(project.projectTitle)
                
                ProgressView(value: project.completionAmount)
                    .accentColor(Color(project.projectColor))
            }.padding(.bottom, 10)
            
            Spacer()
            
            NavigationLink(destination: EditProjectView(project: project)) {
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
            }
        }
    }
}

struct ProjectHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectHeaderView(project: Project.example)
    }
}
