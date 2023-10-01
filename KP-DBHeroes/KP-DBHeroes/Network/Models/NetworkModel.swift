//
//  NetworkModel.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//

import Foundation

final class NetworkModel {

    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case invalidToken
        case decodingFailed
        case noData
        case statusCode(code: Int?)
        case unknown
    }

    enum HTTPMethod: String {
        case post = "POST"
    }

    private let apiURL: String

    private static var token: String?

    init(apiURL: String = "https://dragonball.keepcoding.education") {
        self.apiURL = apiURL
    }

    func fetchHeroes(requestData: DBHeroRequest,
                     completion: @escaping (Result<[DBHeroResponse], NetworkError>) -> Void) {
        let path = "/api/heros/all"
        guard let url = URL(string: apiURL + path) else { return completion(.failure(.invalidURL)) }
        guard let token = NetworkModel.token else { return completion(.failure(.invalidToken)) }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = try? JSONEncoder().encode(requestData)
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)",
                                       "Content-Type": "application/json"]

        let urlSession = URLSession.shared

        let task = urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                      let dragonBallResponse = try? JSONDecoder().decode([DBHeroResponse].self, from: data) else {
                    return completion(.failure(.invalidResponse))
                }

                completion(.success(dragonBallResponse))
            }
        }
        task.resume()
    }
    
    func fetchTransformations(requestData: TransformationRequest,
                     completion: @escaping (Result<[TransformationResponse], NetworkError>) -> Void) {
        let path = "/api/heros/tranformations"
        guard let url = URL(string: apiURL + path) else { return completion(.failure(.invalidURL)) }
        guard let token = NetworkModel.token else { return completion(.failure(.invalidToken)) }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = try? JSONEncoder().encode(requestData)
        request.allHTTPHeaderFields = ["Authorization": "Bearer \(token)",
                                       "Content-Type": "application/json"]

        let urlSession = URLSession.shared

        let task = urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data,
                      let transformationResponse = try? JSONDecoder().decode([TransformationResponse].self, from: data) else {
                    return completion(.failure(.invalidResponse))
                }

                completion(.success(transformationResponse))
            }
        }
        task.resume()
    }

    func login(requestData: LoginRequest, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let path = "/api/auth/login"
        guard let url = URL(string: apiURL + path) else {
            completion(.failure(.invalidURL))
            return
        }

        let loginString = String(format: "%@:%@", requestData.username, requestData.password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.decodingFailed))
            return
        }

        let base64LoginString = loginData.base64EncodedString()
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.unknown))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                let urlResponse = response as? HTTPURLResponse
                let statusCode = urlResponse?.statusCode
                
                guard statusCode == 200 else {
                    completion(.failure(.statusCode(code: statusCode)))
                    return
                }
                
                guard let token = String(data: data, encoding: .utf8) else {
                    completion(.failure(.decodingFailed))
                    return
                }
                
                NetworkModel.token = token
                completion(.success(token))
            }
        }
        task.resume()
    }

}
