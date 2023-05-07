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
            if let votes = votingManager.loginResponse?.vote {
                List{
                    Section {
                        Text("Delegate: \(votes.delegate)")
                    }
                    
                    Section {
                        Text("12 Points: \(votes.points12)")
                        Text("10 Points: \(votes.points10)")
                        Text("8 Points: \(votes.points8)")
                        Text("7 Points: \(votes.points7)")
                        Text("6 Points: \(votes.points6)")
                        Text("5 Points: \(votes.points5)")
                        Text("4 Points: \(votes.points4)")
                        Text("3 Points: \(votes.points3)")
                        Text("2 Points: \(votes.points2)")
                        Text("1 Points: \(votes.points1)")
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
