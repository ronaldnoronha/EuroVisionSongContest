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

    var body: some View {
        NavigationStack {
            if let loginResponse = manager.loginResponse,
                manager.isLoggedIn {
                if loginResponse.hasVoted {
                    VotesSummaryView(country: loginResponse.country, votingManager: manager)
                } else {
                    VotingView(country: loginResponse.country, votingManager: manager, songs: manager.loginResponse!.songs)
                }
            } else {
                LoginView(loginManager: manager)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
    }
}
