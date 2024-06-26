//
//  YouTubePlayerView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 12/4/2023.
//

import SwiftUI

import YouTubePlayerKit

struct VideoView: View {
    let videoId: String
    
    var body: some View {
        YouTubePlayerView(getYouTubeLink(videoId))
    }
    
    func getYouTubeLink(_ videoId: String) -> YouTubePlayer {
        return YouTubePlayer(stringLiteral: "https://youtube.com/watch?v=\(videoId)")
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videoId: "kiIhvA2Ozzk")
    }
}
