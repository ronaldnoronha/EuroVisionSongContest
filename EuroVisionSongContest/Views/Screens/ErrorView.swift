//
//  ErrorVie.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 25/4/2023.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            Text("An error has occurred!")
                .font(.title)
                .padding(.bottom)
            Text("The operation could not be completed!")
                .font(.headline)
            Spacer()
        }
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
