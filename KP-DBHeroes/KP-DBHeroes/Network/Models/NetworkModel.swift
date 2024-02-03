//
//  NetworkModel.swift
//  KP-DBHeroes
//
//  Created by Daniel Cazorro Frías on 22/9/23.
//
import Foundation

// MARK: - NetworkError + Extension
// Enum para representar errores de red
enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case invalidToken
    case decodingFailed
    case noData
    case statusCode(code: Int?)
    case unknown
}

extension NetworkError {
    // Método para mapear códigos de error a NetworkError
    static func error(for code: Int) -> NetworkError? {
        switch code {
        case 0: return .statusCode(code: nil)
        case 1: return .invalidURL
        case 2: return .noData
        case 3: return .statusCode(code: 400)
        case 4: return .decodingFailed
        case 5: return .unknown
        default: return nil
        }
    }
}

// MARK: - Protocol
// Protocolo para el cliente de la API
protocol APIClientProtocol {
    var session: URLSession { get }
    func request<T: Decodable>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
    func jwt(_ request: URLRequest, completion: @escaping (Result<String, NetworkError>) -> Void)
}

// MARK: - Api Client
// Implementación del cliente de la API
struct APIClient: APIClientProtocol {
    static let shared = APIClient()
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // Método para realizar una solicitud JWT
    func jwt(
        _ request: URLRequest,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<String, NetworkError>
            
            defer {
                completion(result)
            }
            
            guard error == nil else {
                if let error = error as? NSError, let error = NetworkError.error(for: error.code) {
                    result = .failure(error)
                } else {
                    result = .failure(.unknown)
                }
                return
            }
            
            guard let data = data else {
                result = .failure(.noData)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                result = .failure(.statusCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let response = String(data: data, encoding: .utf8) else {
                result = .failure(.decodingFailed)
                return
            }
            result = .success(response)
        }
        
        task.resume()
    }
    
    // Método para realizar una solicitud genérica
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let task = session.dataTask(with: request) { data, response, error in
            let result: Result<T, NetworkError>
            
            defer {
                completion(result)
            }
            
            guard error == nil else {
                if let error = error as? NSError, let error = NetworkError.error(for: error.code) {
                    result = .failure(error)
                } else {
                    result = .failure(.unknown)
                }
                return
            }
            
            guard let data = data else {
                result = .failure(.noData)
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                result = .failure(.statusCode(code: (response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            guard let response = try? JSONDecoder().decode(using, from: data) else {
                result = .failure(.decodingFailed)
                return
            }
            result = .success(response)
        }
        
        task.resume()
    }
}

// MARK: - NetworkModel
// Clase que gestiona las solicitudes a la red
final class NetworkModel {
    
    private var token: String? {
        get {
            if let token = LocalDataModel.getToken() {
                return token
            }
            return nil
        }
        set {
            if let token = newValue {
                LocalDataModel.save(token: token)
            }
        }
    }
    // Componentes base de la URL
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private let client: APIClientProtocol
    
    init(
        client: APIClientProtocol = APIClient.shared
    ) {
        self.client = client
    }
    
    // Método para realizar el inicio de sesión
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        guard let url = components.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let loginString = String(format: "%@:%@", user, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // Realizar la solicitud JWT
        client.jwt(urlRequest) { [weak self] expectedResult in
            switch expectedResult {
            case let .success(token):
                self?.token = token
                LocalDataModel.save(token: token)
                completion(.success(token))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // Método para obtener los héroes
    func getHeroes(
        completion: @escaping (Result<[Hero], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/all"
        guard let url = components.url,
              let token else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "name", value: "")]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        // Realizar la solicitud de héroes
        client.request(urlRequest, using: [Hero].self, completion: completion)
    }
    
    // Método para obtener las transformaciones de un héroe
    func getTransformations(
        for hero: Hero,
        completion: @escaping (Result<[Transformation], NetworkError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        guard let url = components.url,
              let token else {
            completion(.failure(.invalidURL))
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.queryItems = [URLQueryItem(name: "id", value: hero.id)]
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        
        // Realizar la solicitud de transformaciones
        client.request(urlRequest, using: [Transformation].self, completion: completion)
    }
}
