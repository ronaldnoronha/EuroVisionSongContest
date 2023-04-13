//
//  TallyDashboardView.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 13/4/2023.
//

import SwiftUI

struct TallyDashboardView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink (destination: TallyVotesView()) {
                    Text("Votes Cast")
                        .font(.title2)
                }
    
                Button("Start Presentation") {
                    print("Start Presentation")
                }
            }
        }
    }
}

struct TallyDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        TallyDashboardView()
    }
}
