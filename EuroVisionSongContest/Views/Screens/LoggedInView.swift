//
//  LoggedInView.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 19/4/2023.
//

import SwiftUI

struct LoggedInView: View {
    let country: String
    var body: some View {
        Text("\(country.uppercased())")
    }
}

struct LoggedInView_Previews: PreviewProvider {
    static var previews: some View {
        LoggedInView(country: "Australia")
    }
}
