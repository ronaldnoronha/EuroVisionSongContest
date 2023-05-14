//
//  VoteSummaryCellView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 14/5/2023.
//

import SwiftUI

struct VoteSummaryCellView: View {
    let points: Int
    let country: String
    var body: some View {
        HStack {
            Text("\(points) Points:")
            Spacer()
            Image(country)
                .resizable()
                .frame(maxWidth: 50, maxHeight: 50)
            Text("\(country.capitalized)")
        }
    }
}

struct VoteSummaryCellView_Previews: PreviewProvider {
    static var previews: some View {
        VoteSummaryCellView(points: 12, country: "australia")
    }
}
