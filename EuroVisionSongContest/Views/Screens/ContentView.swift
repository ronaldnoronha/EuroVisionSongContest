//
//  ContentView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 6/5/2022.
//

import CoreData
import SwiftUI


struct ContentView: View {
    @EnvironmentObject private var manager: EurovisionManager
    
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                if let loginResponse = manager.loginResponse,
                    manager.isLoggedIn {
                    if loginResponse.hasVoted {
                        VotesSummaryView(country: loginResponse.country)
                    } else {
                        VotingView(country: loginResponse.country, songs: manager.loginResponse!.songs)
                    }
                } else {
                    LoginView()
                }
            }
            .tabItem {
              Label("Home", systemImage: "house")
            }
            .tag(0)

            Text("Settings View")
            .tabItem {
              Label("Settings", systemImage: "gear")
            }
            .tag(1)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(EurovisionManager())
    }
}
