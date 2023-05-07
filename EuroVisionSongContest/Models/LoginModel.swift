//
//  Representation.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 24/4/2023.
//

import Foundation

struct LoginResponse: Codable {
    let country: String
    let delegate: String
    let hasVoted: Bool
    let vote: Vote?
    let songs: [Song]
}
