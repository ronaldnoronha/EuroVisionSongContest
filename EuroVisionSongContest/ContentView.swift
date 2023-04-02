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
            return Image("united-kingdom")
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
        
        VStack {
            Button(action: { print(title) }) {
                Image(title)
                    .resizable()
                    .frame(maxWidth: 100, maxHeight: 100)
            }
            .padding()
            Text(title.uppercased())
                .font(.subheadline)
                .bold()
                .fontDesign(.rounded)
            
        }
    }
}

struct ContentView: View {
    let gridColumns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 10) {
                ForEach(participants, id: \.self) { country in
                    CountryButton(title: country)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.landscapeLeft)
    }
}
