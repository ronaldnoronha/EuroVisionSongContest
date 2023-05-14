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
    let impact = UIImpactFeedbackGenerator(style: .heavy)
    var body: some View {
        NavigationStack {
            if let votes = votingManager.loginResponse?.vote {
                List{
                    Section {
                        HStack{
                            Text("Delegate:")
                            Spacer()
                            Text("\(votes.delegate.capitalized)")
                                    
                        }
                    }
                    Section {
                        VoteSummaryCellView(points: 12, country: votes.points12)
                        VoteSummaryCellView(points: 10, country: votes.points10)
                        VoteSummaryCellView(points: 8, country: votes.points8)
                        VoteSummaryCellView(points: 7, country: votes.points7)
                        VoteSummaryCellView(points: 6, country: votes.points6)
                        VoteSummaryCellView(points: 5, country: votes.points5)
                        VoteSummaryCellView(points: 4, country: votes.points4)
                        VoteSummaryCellView(points: 3, country: votes.points3)
                        VoteSummaryCellView(points: 2, country: votes.points2)
                        VoteSummaryCellView(points: 1, country: votes.points1)
                    }
                }
                .background(
                    Image("eurovision")
                        .resizable()
                        .frame(maxWidth: 900, maxHeight: 900)
                        .opacity(0.25)
                )

            }            
        }
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
                    impact.impactOccurred()
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
