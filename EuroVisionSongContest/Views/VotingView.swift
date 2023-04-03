//
//  VotingView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 7/5/2022.
//

import SwiftUI

struct VotingView: View {
    @State private var selectedDelegate: String?
    @State private var choosenPoints: [Int]?
    let songs = getSongEntries()
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $selectedDelegate, label: Text("Delegate")) {
                    ForEach(delegates, id:\.self) { option in
                        Text(option)
                    }
                }
            }
            Section {
                Text("Add your points")
                List {
                    ForEach(songs, id:\.self) { song in
                        Text(song.country.capitalized)
                    }
                }                
            }
        }
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView()
    }
}
