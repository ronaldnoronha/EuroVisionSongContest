//
//  CountryButton.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 3/4/2023.
//

import SwiftUI

struct CountryButton: View {
    let title: String
    var body: some View {
        
        VStack {
            Image(title)
                .resizable()
                .frame(maxWidth: 100, maxHeight: 100)
                .padding()
            
            Text(title.uppercased())
                .font(.subheadline)
                .bold()
                .fontDesign(.rounded)
            
        }
    }
}

struct CountryButton_Previews: PreviewProvider {
    static var previews: some View {
        CountryButton(title: "united-kingdom")
    }
}
