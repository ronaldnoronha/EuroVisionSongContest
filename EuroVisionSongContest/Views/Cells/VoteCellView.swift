//
//  VoteCellView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 5/4/2023.
//

import SwiftUI

struct VoteCellView: View {
    @State private var isYouTubeLinkOpened = false
        @State private var isYouTubeAppNotInstalledAlertPresented = false
    let impactMed = UIImpactFeedbackGenerator(style: .medium)
        var body: some View {
            VStack {
                // List of cells
                List {
                    ForEach(0..<10, id: \.self) { index in
                        Button(action: {
                            impactMed.impactOccurred()
                            openYouTubeLink()
                        }) {
                            Text("Cell \(index)")
                        }
                    }
                }
            }
            .alert(isPresented: $isYouTubeAppNotInstalledAlertPresented) {
                Alert(
                    title: Text("YouTube App Not Installed"),
                    message: Text("Please install the YouTube app to view the video."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        
        func openYouTubeLink() {
            let youtubeURL = URL(string: "https://www.youtube.com/watch?v=VIDEO_ID")!
            if UIApplication.shared.canOpenURL(youtubeURL) {
                UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
            } else {
                // Handle if YouTube app is not installed
                isYouTubeAppNotInstalledAlertPresented = true
            }
        }
}

struct VoteCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        VoteCellView()
    }
}
