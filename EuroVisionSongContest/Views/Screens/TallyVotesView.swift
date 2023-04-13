//
//  TallyVotesView.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 13/4/2023.
//

import SwiftUI

struct TallyVotesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.delegate)])
    
    private var votes: FetchedResults<Votes>
    
    var body: some View {
        List(votes) { vote in
            Text(vote.delegate ?? "Blank")
        }
    }
}

struct TallyVotesView_Previews: PreviewProvider {
    static var previews: some View {
        TallyVotesView()
    }
}
