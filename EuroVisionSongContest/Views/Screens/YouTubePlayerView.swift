//
//  YouTubePlayerView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 12/4/2023.
//

import SwiftUI
import WebKit

struct YouTubePlayerViewRepresentable: UIViewRepresentable {
    let videoId: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let htmlString = """
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                </head>
                <body>
                    <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoId)" frameborder="0" allowfullscreen></iframe>
                </body>
            </html>
        """
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
}

struct YouTubePlayerView: View {
    let videoId: String
    var body: some View {
        GeometryReader { geometry in
            YouTubePlayerViewRepresentable(videoId: videoId)
                .frame(
                    width: min(geometry.size.width, 650),
                    height: min(geometry.size.height, 325)
                )
                .padding()
        }
    }
}

struct YouTubePlayerView_Previews: PreviewProvider {
    static var previews: some View {
        YouTubePlayerView(videoId: "mp8OG4ApocI")
    }
}
