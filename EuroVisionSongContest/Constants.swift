//
//  Constants.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 2/4/2023.
//

import Foundation


let participants: [String] = [
    "albania",
    "armenia",
    "australia",
    "austria",
    "azerbaijan",
    "belarus",
    "belgium",
    "bosnia-and-herzegovina",
    "bulgaria",
    "croatia",
    "cyprus",
    "czechia",
    "denmark",
    "estonia",
    "finland",
    "france",
    "georgia",
    "germany",
    "greece",
    "hungary",
    "iceland",
    "ireland",
    "israel",
    "italy",
    "latvia",
    "lithuania",
    "luxembourg",
    "malta",
    "moldova",
    "montenegro",
    "morocco",
    "netherlands",
    "north-macedonia",
    "norway",
    "poland",
    "portugal",
    "romania",
    "russia",
    "san-marino",
    "serbia",
    "sloakia",
    "slovenia",
    "spain",
    "sweden",
    "switzerland",
    "turkey",
    "ukraine",
    "united-kingdom"
]

func getSongEntries(country: String) -> [Song] {
    guard let fileUrl = Bundle.main.url(forResource: "SongEntries", withExtension: "json") else {
        fatalError("Couldn't find file in app bundle")
    }

    do {
        let jsonData = try Data(contentsOf: fileUrl)
        let decoder = JSONDecoder()
        var songs = try decoder.decode([Song].self, from: jsonData)
        songs = songs.filter { $0.country != country }
        return songs
    } catch {
        fatalError("Couldn't decode object from JSON: \(error)")
    }
}


