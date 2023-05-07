//
//  VotingView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 7/5/2022.
//

import SwiftUI
import SafariServices

struct VotingView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext
    
    let country: String
    @ObservedObject var votingManager: EurovisionManager
    let songs: [Song]
    
    @State private var points: [Int] = [12,10,8,7,6,5,4,3,2,1,0]
    @State private var selectedNumbers: [Int]
    @State private var isYouTubeLinkOpened = false
    @State private var showModal = false
    @State private var validVotes = false
    
    init(country: String, votingManager: EurovisionManager, songs: [Song]) {
        self.country = country
        self.votingManager = votingManager
        self.songs = songs
        _selectedNumbers = State(initialValue: [Int](repeating: 0, count: songs.count))
    }

    var body: some View {
        NavigationStack {
            Form {
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
                                YouTubePlayerView(videoId: songs[index].link)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            .onChange(of: selectedNumbers) { _ in
                                validVotes = points.count == Set(selectedNumbers).count ? true : false                                
                            }
                        }
                    } // :LIST
                } // :SECTION
            } // :FORM
        } // :NAVIGATION
        .background(
            Image("eurovision")
                .resizable()
                .frame(maxWidth: 900, maxHeight: 900)
                .opacity(0.25)
        )
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
//                    let votes = Votes(context: managedObjectContext)
//                    votes.delegate = votingManager.loginResponse?.delegate
//                    votes.country = country
//                    votes.points12 = songs[selectedNumbers.firstIndex(of: 12)!].country
//                    votes.points10 = songs[selectedNumbers.firstIndex(of: 10)!].country
//                    votes.points8 = songs[selectedNumbers.firstIndex(of: 8)!].country
//                    votes.points7 = songs[selectedNumbers.firstIndex(of: 7)!].country
//                    votes.points6 = songs[selectedNumbers.firstIndex(of: 6)!].country
//                    votes.points5 = songs[selectedNumbers.firstIndex(of: 5)!].country
//                    votes.points4 = songs[selectedNumbers.firstIndex(of: 4)!].country
//                    votes.points3 = songs[selectedNumbers.firstIndex(of: 3)!].country
//                    votes.points2 = songs[selectedNumbers.firstIndex(of: 2)!].country
//                    votes.points1 = songs[selectedNumbers.firstIndex(of: 1)!].country
//
//                    do {
//                        try managedObjectContext.save()
//                    } catch {
//                        let nsError = error as NSError
//                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                    }
                    
                    // Add service call to submit votes
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(!validVotes)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Logout") {
                    votingManager.logout()
                }
            }
        }
    }
}

struct VotingView_Previews: PreviewProvider {
    static var manager = EurovisionManager()
    static var previews: some View {
        VotingView(country: "australia", votingManager: manager, songs: getSongEntries(country: "australia"))
    }
}
