//
//  VotesSummaryView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 27/4/2023.
//

import SwiftUI

struct VotesSummaryView: View {
    let country: String
    var body: some View {
        Text("Votes Summary View for \(country)")
    }
}

struct VotesSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        VotesSummaryView(country: "Australia")
    }
}
