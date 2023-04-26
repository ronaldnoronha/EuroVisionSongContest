//
//  ContentView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 6/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var manager = EurovisionManager()
    
    let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            if let country = manager.country, manager.isLoggedIn {
                LoggedInView(country: country)
            } else {
                LoginView(loginManager: manager)
            }

//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    NavigationLink(destination: TallyDashboardView(), label: {Text("Tally")})
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Reset") {
//                        print("reset")
//                    }
//                }
//            }
//            .navigationTitle("Choose your country")
//            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
    }
}
