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

//enum RequestMethod: String {
//    case delete = "DELETE"
//    case get = "GET"
//    case post = "POST"
//    case put = "PUT"
//}

class EurovisionManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var country: String?
    @Published var isUnsuccessfulLogin = false
    
    func login(name: String, password: String) async throws {
        let url = URL(string: "https://3ad7-111-220-61-208.ngrok-free.app/login")
        let queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "password", value: password)
        ]
        guard let newURL = url?.appending(queryItems: queryItems) else  {
            throw RequestError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: newURL)
        do {
            let response = try JSONDecoder().decode(RepresentationResponse.self, from: data)
            DispatchQueue.main.async {
                self.country = response.country
                self.isUnsuccessfulLogin = false
                self.isLoggedIn = true
            }
        } catch {
            self.isUnsuccessfulLogin = true
            self.isLoggedIn = false
        }
    }
    
    func signup() {}
    
    func submitVotes() {}
    
    func retrieveVote() {}
}
