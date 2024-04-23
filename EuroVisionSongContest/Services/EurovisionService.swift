//
//  EurovisionService.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 18/4/2023.
//

import SwiftUI

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
}

class EurovisionManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isUnsuccessfulLogin = false
    @Published var userSignupFailed = false
    @Published var isScannedURLCurrent = false
    
    @Published var loginResponse: LoginResponse?
    
    @AppStorage("url", store: UserDefaults(suiteName: "com.eurovision"))
    var scannedURL: String = ""

    enum Constants {
        static let login = "/login"
        static let signup = "/signup"
        static let votes = "/votes"
        static let submit = "/submit"
        static let hasVoted = "/hasVoted"
        static let getVotes = "/getVotes"
        static let ping = "/ping"
    }
    
    struct SignupRequest: Encodable {
        let name: String
        let password: String
    }
    
    struct HasVotedResponse: Codable {
        let hasVoted: Bool
    }
    
    struct PongResponse: Codable {
        let connection: Bool
    }
    
    func setScannedURL(url: String) {
        scannedURL = url
        Task {
            try await ping()
        }
    }

    func ping() async throws {
        var url = URLComponents(string: scannedURL)
        url?.path = Constants.ping
        
        guard let url = url?.url else {
            isScannedURLCurrent = false
            scannedURL = ""
            throw RequestError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let response = try JSONDecoder().decode(PongResponse.self, from: data)
            if response.connection {
                isScannedURLCurrent = true
            }
        } catch {
            isScannedURLCurrent = false
            scannedURL = ""
        }
    }

    func login(name: String, password: String) async throws {
        var url = URLComponents(string: scannedURL)
        url?.path = Constants.login
        let queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "password", value: password)
        ]
        url?.queryItems = queryItems
        guard let url = url?.url else {
            throw RequestError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let response = try JSONDecoder().decode(LoginResponse.self, from: data)
            loginResponse = response
            isUnsuccessfulLogin = false
            isLoggedIn = true
        } catch {
            DispatchQueue.main.async {
                self.isUnsuccessfulLogin = true
                self.isLoggedIn = false
            }
        }
    }
    
    func signup(name: String, password: String) async throws {
        var url = URLComponents(string: scannedURL)
        url?.path = Constants.signup
        
        guard let url = url?.url else {
            throw RequestError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let requestData = try encoder.encode(SignupRequest(name: name, password: password))
        
        let (data, _) = try await URLSession.shared.upload(for: request, from: requestData)
            
        do {
            let response = try JSONDecoder().decode(LoginResponse.self, from: data)
            loginResponse = response
            userSignupFailed = false
            isLoggedIn = true
        } catch {
            DispatchQueue.main.async {
                self.userSignupFailed = true
                self.isLoggedIn = false
            }
        }
    }
    
    func submitVotes(vote: Vote) async throws {
        var url = URLComponents(string: scannedURL)
        url?.path = Constants.submit
        
        guard let url = url?.url else {
            throw RequestError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        let requestData = try encoder.encode(vote)
        
        try await URLSession.shared.upload(for: request, from: requestData)
        loginResponse = LoginResponse(
            country: loginResponse?.country ?? "",
            delegate: loginResponse?.delegate ?? "",
            hasVoted: true,
            vote: vote,
            songs: []
        )
    }
    
    func logout() {
        isLoggedIn = false
        setToDefault()
    }
    
    func setToDefault() {
        isUnsuccessfulLogin = false
        userSignupFailed = false
    }
}
