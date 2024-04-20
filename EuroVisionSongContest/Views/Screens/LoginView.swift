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
    
    @EnvironmentObject var loginManager: EurovisionManager
    let impact = UIImpactFeedbackGenerator(style: .heavy)

    var isLoginButtonDisabled: Bool {
        [name, password].contains(where: \.isEmpty)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Image("eurovision").resizable()
                    .resizable()
                    .frame(maxWidth: 900, maxHeight: 900)
                    .opacity(0.25)
                
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
                            impact.impactOccurred()
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
                            impact.impactOccurred()
                            Task {
                                try await loginManager.signup(name: name, password: password)
                            }
                        } label: {
                            Text("Signup")
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
                    }
                                    
                    if loginManager.isUnsuccessfulLogin {
                        Text("Wrong details! Try again")
                            .fontWeight(.heavy)
                            .italic()
                            .bold()
                            .foregroundColor(.red)
                    }
                    
                    if loginManager.userSignupFailed {
                        Text("User already exists")
                            .fontWeight(.heavy)
                            .italic()
                            .bold()
                            .foregroundColor(.red)
                    }
                }
                .opacity(0.85)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Login").font(.headline)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(EurovisionManager())
    }
}
