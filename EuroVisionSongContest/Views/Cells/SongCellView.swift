//
//  SongCellView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 5/4/2023.
//

import SwiftUI

struct SongCellView: View {
    var song: Song
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(song.country)
                    .resizable()
                    .frame(maxWidth: 50, maxHeight: 50)
                Text("\(song.country.uppercased())")
                    .font(.subheadline)
                    .padding()
            }
            
            HStack {
                Spacer()
                Text("\(song.songName)")
                    .font(.headline)
                Spacer()
            }
        }
    }
}

struct SongCellView_Previews: PreviewProvider {
    static var previews: some View {
        SongCellView(song: getSongEntries(country: "australia")[0])
    }
}
 
