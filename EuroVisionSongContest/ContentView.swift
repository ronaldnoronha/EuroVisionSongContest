//
//  ContentView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 6/5/2022.
//

import SwiftUI
import CoreData

enum Countries {
    case uk
    case australia
    case austria
    
    
    var image: Image {
        switch self {
        case .uk:
            return Image("uk")
        case .austria:
            return Image("austria")
        case .australia:
            return Image("australia")
        }
    }
}

struct CountryButton: View {
    @State private var isStarting = true
    
    
    let title: String
    var body: some View {
        Button(action: { print(title) }) {
            Image(title)
                .resizable()
                .frame(width: 100, height: 50)
                .cornerRadius(8)
                .opacity(0.9)
        }
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        HStack{
            Spacer()
            VStack {
                Spacer()
                CountryButton(title: "uk")
                Spacer()
                CountryButton(title: "australia")
                Spacer()
                CountryButton(title: "austria")
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                CountryButton(title: "germany")
                Spacer()
                CountryButton(title: "france")
                Spacer()
                CountryButton(title: "spain")
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                CountryButton(title: "italy")
                Spacer()
                CountryButton(title: "sweden")
                Spacer()
                CountryButton(title: "")
                Spacer()
            }
            Spacer()
        }
        .background(
            Image("eurovisionLogo")
                .resizable()
                .rotationEffect(.degrees(90))
                .frame(width: 1000, height: 1100)
                .opacity(0.5)
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
    }
}
