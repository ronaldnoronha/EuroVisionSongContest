//
//  VotingView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 7/5/2022.
//

import SwiftUI
import SafariServices

struct VotingView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var votingManager: EurovisionManager
    
    let country: String
    let songs: [Song]
    
    @State private var points: [Int] = [12,10,8,7,6,5,4,3,2,1,0]
    @State private var selectedNumbers: [Int]
    @State private var isYouTubeLinkOpened = false
    @State private var showModal = false
    var songVideoId: String?
    @State private var validVotes = false
    let impact = UIImpactFeedbackGenerator(style: .heavy)
    
    init(country: String, songs: [Song]) {
        self.country = country
        self.songs = songs
        _selectedNumbers = State(initialValue: [Int](repeating: 0, count: songs.count))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("eurovision").resizable()
                    .resizable()
                    .frame(maxWidth: 900, maxHeight: 900)
                    .opacity(0.25)
                
                Form {
                    Section{
                        Text("Delegate: \(votingManager.loginResponse?.delegate ?? "")")
                    }
                    
                    Section {
                        Text("Add your points")
                            .font(.headline)
                            .padding()
                        
                        if points.count - Set(selectedNumbers).count == 0 {
                            Text("If finalised please submit votes")
                                .font(.callout)
                                .padding()
                        } else {
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
                                    if let songVideoId = songVideoId {
                                        VideoView(videoId: songVideoId)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                }
                                .onChange(of: selectedNumbers) { _ in
                                    validVotes = points.count == Set(selectedNumbers).count ? true : false
                                }
                            }
                        } // :LIST
                    } // :SECTION
                } // :FORM
                .opacity(0.85)
            }
        } // :NAVIGATION
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
                Button("Submit") {
                    impact.impactOccurred()
                    let vote = Vote(
                        delegate: votingManager.loginResponse?.delegate ?? "",
                        country: country,
                        points12: songs[selectedNumbers.firstIndex(of: 12)!].country,
                        points10: songs[selectedNumbers.firstIndex(of: 10)!].country,
                        points8: songs[selectedNumbers.firstIndex(of: 8)!].country,
                        points7: songs[selectedNumbers.firstIndex(of: 7)!].country,
                        points6: songs[selectedNumbers.firstIndex(of: 6)!].country,
                        points5: songs[selectedNumbers.firstIndex(of: 5)!].country,
                        points4: songs[selectedNumbers.firstIndex(of: 4)!].country,
                        points3: songs[selectedNumbers.firstIndex(of: 3)!].country,
                        points2: songs[selectedNumbers.firstIndex(of: 2)!].country,
                        points1: songs[selectedNumbers.firstIndex(of: 1)!].country
                    )
                    Task {
                        try await votingManager.submitVotes(vote: vote)
                        //TODO: - Login response update after submitting vote
                    }
                }
                .disabled(!validVotes)
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

struct VotingView_Previews: PreviewProvider {
    static var previews: some View {
        VotingView(country: "australia", songs: getSongEntries(country: "australia"))
            .environmentObject(EurovisionManager())
    }
}
