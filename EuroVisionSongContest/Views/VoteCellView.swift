//
//  VoteCellView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 5/4/2023.
//

import SwiftUI

struct VoteCellView: View {
//    @Binding var points: [Int]
//    @Binding var selectedNumber: Int
//
//    init(points: Binding<[Int]>, selectedNumber: Binding<Int>) {
//        _points = points
//        _selectedNumber = selectedNumber
//    }
//
//    var body: some View {
//        Picker("", selection: $selectedNumber) {
//            ForEach(points.filter { !(selectedNumber == $0) }, id:\.self) { number in
//                Text("\(number)")
//            }
//        }
//        .pickerStyle(MenuPickerStyle())
////        .onChange(of: selectedNumber) { newValue in
//////            updateSelectedNumbers()
////        }
//    }
    @State private var numbers = [12, 10, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    @State private var selectedNumbers: [Int]
        
    init() {
        selectedNumbers = [0,0,0,0,0]
    }
        
    var body: some View {
        VStack {
            List {
                ForEach(0..<selectedNumbers.count, id: \.self) { index in
                    Picker("", selection: $selectedNumbers[index]) {
                        ForEach(numbers.filter { !selectedNumbers.contains($0) || $0 == selectedNumbers[index] }, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
        }
    }
}

struct VoteCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        VoteCellView()
    }
}
