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
    "belgium",
    "bulgaria",
    "croatia",
    "cyprus",
    "czech-republic",
    "denmark",
    "estonia",
    "finland",
    "france",
    "germany",
    "georgia",
    "greece",
    "iceland",
    "ireland",
    "israel",
    "italy",
    "latvia",
    "lithuania",
    "malta",
    "moldova",
    "montenegro",
    "netherlands",
    "north-macedonia",
    "norway",
    "poland",
    "portugal",
    "romania",
    "san-marino",
    "serbia",
    "slovenia",
    "spain",
    "sweden",
    "switzerland",
    "ukraine",
    "united-kingdom"
]

let delegates: [String] = [
    "Aarushi",
    "Claudio",
    "Harish",
    "Jordy",
    "Ron",
    "Tony"
]

func getSongEntries() -> [Song] {
    guard let fileUrl = Bundle.main.url(forResource: "SongEntries", withExtension: "json") else  {
        fatalError("Couldn't find file in app bundle")
    }

    do {
        let jsonData = try Data(contentsOf: fileUrl)
        let decoder = JSONDecoder()
        let songs = try decoder.decode([Song].self, from: jsonData)
        return songs
    } catch {
        fatalError("Couldn't decode object from JSON: \(error)")
    }
}

var songs: [Song] = getSongEntries()



