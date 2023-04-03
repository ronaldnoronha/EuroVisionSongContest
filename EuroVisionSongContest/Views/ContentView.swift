//
//  ContentView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 6/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: gridColumns, spacing: 10) {
                    ForEach(participants, id: \.self) { country in
                        NavigationLink(destination: VotingView()) {
                            CountryButton(title: country)
                        }
                    }
                }
            }
            .background(
                Image("eurovision")
                    .resizable()
                    .frame(maxWidth: 900, maxHeight: 900)
                    .opacity(0.25)
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Tally") {
                        print("tally")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reset") {
                        print("reset")
                    }
                }
            }
            .navigationTitle("Choose your country")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
    }
}
