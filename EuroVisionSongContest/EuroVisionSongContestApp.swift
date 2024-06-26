//
//  EuroVisionSongContestApp.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 6/5/2022.
//

import SwiftUI

@main
struct EuroVisionSongContestApp: App {
    let persistenceController = PersistenceController.shared
    let eurovisionManager = EurovisionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(eurovisionManager)
        }
    }
}
