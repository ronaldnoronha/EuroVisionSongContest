//
//  SettingsView.swift
//  EuroVisionSongContest
//
//  Created by Ronald Noronha on 23/4/2024.
//

import SwiftUI

import CodeScanner

struct SettingsView: View {
    @EnvironmentObject private var manager: EurovisionManager
    
    @State private var isShowingScanner: Bool = false
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            Image("eurovision").resizable()
                .resizable()
                .frame(maxWidth: 900, maxHeight: 900)
                .opacity(0.25)
            VStack {
                Spacer()
                
                if manager.scannedURL.isEmpty {
                    Text("No URL, scan using the button below")
                        .fontWeight(.heavy)
                        .bold()
                        .foregroundColor(.red)
                } else {
                    Text(manager.scannedURL)
                        .fontWeight(.heavy)
                        .bold()
                    if !manager.isScannedURLCurrent {
                        Text("URL above is not valid, scan again")
                            .fontWeight(.heavy)
                            .bold()
                            .foregroundColor(.red)
                    }
                }
            
                Image(systemName: manager.isScannedURLCurrent ? "wifi" : "wifi.exclamationmark")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                if manager.scannedURL.isEmpty || !manager.isScannedURLCurrent {
                    Text("To scan tap below")
                        .fontWeight(.heavy)
                        .bold()
                        .foregroundColor(.blue)
                }
                Button {
                    isShowingScanner = true
                } label: {
                    Image(systemName: "qrcode.viewfinder")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            }
        }
        .task {
            do {
                try await manager.ping()
            } catch {
                
            }
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], completion: handleScan)
        }
        .padding()
        .opacity(0.85)
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let result):
            let url = result.string
            updateURL(url: url)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func updateURL(url: String) {
        manager.scannedURL = url
        manager.setScannedURL(url: url)
        if manager.isScannedURLCurrent {
            selectedTab = 0
        }
    }
}

#Preview {
    @State var selectedTab: Int = 1
    return SettingsView(selectedTab: $selectedTab)
        .environmentObject(EurovisionManager())
}
