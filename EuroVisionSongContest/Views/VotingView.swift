//
//  VotingView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 7/5/2022.
//

import SwiftUI
import SafariServices

struct VotingView: View {
    @State private var selectedDelegate: String?
    @State private var points: [Int] = [12,10,8,7,6,5,4,3,2,1,0]
    @State private var selectedNumbers: [Int]
    @State private var isYouTubeLinkOpened = false
    @State private var showModal = false

    init() {
        selectedNumbers = Array(repeating: 0, count: songs.count)
    }
    
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
                    .font(.headline)
                    .padding()
                
                if points.count - Set(selectedNumbers).count > 0 {
                    Text("Songs left to be selected: \(points.count - Set(selectedNumbers).count)")
                        .font(.callout)
                        .foregroundColor(Color.red)
                        .padding()
                }
                
                List {
                    ForEach(0..<songs.count, id:\.self) { index in
                        Button {
                            showModal = true
                        } label: {
                            HStack {
                                SongCellView(song: songs[index])
                                Picker("", selection: $selectedNumbers[index]) {
                                    ForEach(points.filter { $0 == 0 || !selectedNumbers.contains($0) || $0 == selectedNumbers[index] }, id:\.self) { number in
                                        Text("\(number)")
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                Spacer()
                            }
                        }
                        .sheet(isPresented: $showModal) {
                            YouTubePlayerView(videoId: songs[index].link)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)                            
                        }                        
                    }
                }                
            }
        }
    }
    
    func openYouTubeLink(url: String) {
        guard let youtubeURL = URL(string: url) else { return }
        if UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else {
           
        }
        
    }
}

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView()
    }
}
