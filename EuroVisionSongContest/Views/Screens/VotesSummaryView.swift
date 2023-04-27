//
//  VotesSummaryView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 27/4/2023.
//

import SwiftUI

struct VotesSummaryView: View {
    let country: String
    @ObservedObject var votingManager: EurovisionManager
    var body: some View {
        NavigationStack {
            Text("Votes Summary View for \(country)")
        }
        .background(
            Image("eurovision")
                .resizable()
                .frame(maxWidth: 900, maxHeight: 900)
                .opacity(0.25)
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(country)
                        .resizable()
                        .scaledToFit()
                    Text(country.uppercased()).font(.headline)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    votingManager.logout()
                }
            }
        }
    }
}

struct VotesSummaryView_Previews: PreviewProvider {
    static var manager = EurovisionManager()
    static var previews: some View {
        VotesSummaryView(country: "Australia", votingManager: manager)
    }
}
