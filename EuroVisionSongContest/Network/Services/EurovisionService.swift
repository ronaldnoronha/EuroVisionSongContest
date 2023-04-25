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

final class EurovisionService {
    static func login(name: String, password: String) async throws -> Representation {
        let url = URL(string: "http://localhost:8080/login")
        let queryItems = [
            URLQueryItem(name: "name", value: name),
            URLQueryItem(name: "password", value: password)
        ]
        guard let newURL = url?.appending(queryItems: queryItems) else  {
            throw RequestError.invalidURL
        }

        
        let (data, _) = try await URLSession.shared.data(from: newURL)
        
        let result = try JSONDecoder().decode(Representation.self, from: data)
        return result
    }
}
