//
//  LoginView.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 19/4/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var name = ""
    @State private var password = ""
    @State var representation: Representation?

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: self.$name)
                    .padding()
                TextField("Password", text: self.$password)
                    .padding()
                Button("Login") {
                    print("Logging in")
                    Task {
                        representation = try await EurovisionService.login(name: name, password: password)
                        print(representation?.country)
                        if let representation {
                            LoggedInView(country: representation.country)
                        } else {
                            ErrorView()
                        }
                    }
                }
                .font(.headline)
//                .foregroundColor(Color.white)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.orange)
                .cornerRadius(15.0)
            }
            .background(
              LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            )
        }
        .navigationTitle("Login")
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
