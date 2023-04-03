//
//  SongModel.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 3/4/2023.
//

import Foundation

struct Song: Codable, Hashable {
    let country: String
    let songName: String
    let link: String
}
