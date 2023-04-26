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
    @State var showPassword = false
    
    @ObservedObject var loginManager: EurovisionManager

    var isLoginButtonDisabled: Bool {
        [name, password].contains(where: \.isEmpty)
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                
                TextField(
                    "Name",
                    text: $name,
                    prompt: Text("Login").foregroundColor(.blue)
                )
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                }
                .padding(.horizontal)
                
                HStack {
                    Group {
                        if showPassword {
                            TextField(
                                "Password",
                                text: $password,
                                prompt: Text("Password").foregroundColor(.red)
                            )
                        } else {
                            SecureField(
                                "Password",
                                text: $password,
                                prompt: Text("Password").foregroundColor(.red)
                            )
                        }
                    }
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.red, lineWidth: 2)
                    }
                    
                    Button {
                        showPassword.toggle()
                    } label:  {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.red)
                    }
                } //: HSTACK
                .padding(.horizontal)
                
                Spacer()
                HStack {
                    Button {
                        Task {
                            try await loginManager.login(name: name, password: password)
                        }
                    } label: {
                        Text("Login")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(
                        isLoginButtonDisabled ?
                        LinearGradient(colors: [.gray], startPoint: .topLeading, endPoint: .bottomTrailing) :
                            LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(20)
                    .disabled(isLoginButtonDisabled)
                    .padding()
                    
                    Button {
                        print("Signup")
                    } label: {
                        Text("Signup")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .cornerRadius(20)
                    .padding()
                }
                
                
                if loginManager.isUnsuccessfulLogin {
                    Text("Wrong details! Try again")
                        .fontWeight(.heavy)
                        .italic()
                        .bold()
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            Image("eurovision")
                .resizable()
                .frame(maxWidth: 900, maxHeight: 900)
                .opacity(0.25)
        )
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var manager = EurovisionManager()
    static var previews: some View {
        LoginView(loginManager: manager)
    }
}
