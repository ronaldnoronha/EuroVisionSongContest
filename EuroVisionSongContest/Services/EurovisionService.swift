//
//  EurovisionService.swift
//  EuroVisionSongContest
//
//  Created by Noronha, Ronald on 18/4/2023.
//

import Foundation

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
    @Published var country: String?
    @Published var isUnsuccessfulLogin = false
    @Published var userSignupFailed = false
    @Published var hasVoted = false
    
    enum Constants {
        static let api = "https://3ad7-111-220-61-208.ngrok-free.app"
        static let login = "/login"
        static let signup = "/signup"
        static let votes = "/votes"
        static let submit = "/submit"
        static let hasVoted = "/hasVoted"
    }
    
    struct SignupRequest: Encodable {
        let name: String
        let password: String
    }
    
    struct HasVotedResponse: Codable {
        let hasVoted: Bool
    }
    
    func login(name: String, password: String) async throws {
        var url = URLComponents(string: Constants.api)
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
            let response = try JSONDecoder().decode(RepresentationResponse.self, from: data)
            try await checkIfVoted(country: response.country)
            DispatchQueue.main.async {
                self.country = response.country
                self.isUnsuccessfulLogin = false
                self.isLoggedIn = true
            }
        } catch {
            DispatchQueue.main.async {
                self.isUnsuccessfulLogin = true
                self.isLoggedIn = false
            }
        }
    }
    
    func signup(name: String, password: String) async throws {
        var url = URLComponents(string: Constants.api)
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
            let response = try JSONDecoder().decode(RepresentationResponse.self, from: data)
            try await checkIfVoted(country: response.country)
            DispatchQueue.main.async {
                self.country = response.country
                self.userSignupFailed = false
                self.isLoggedIn = true
            }
        } catch {
            DispatchQueue.main.async {
                self.userSignupFailed = true
                self.isLoggedIn = false
            }
        }
    }
    
    func checkIfVoted(country: String) async throws {
        var url = URLComponents(string: Constants.api)
        url?.path = Constants.hasVoted
        url?.queryItems = [URLQueryItem(name: "country", value: country)]
        
        guard let url = url?.url else {
            throw RequestError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let response = try JSONDecoder().decode(HasVotedResponse.self, from: data)
        DispatchQueue.main.async {
            self.hasVoted = response.hasVoted
        }
    }
    
    func submitVotes() {}
    
    func retrieveVotes() {}
}
