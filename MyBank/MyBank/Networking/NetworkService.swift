//
//  NetworkService.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation
import Alamofire

protocol NetworkService {
    func request<Entity>(method: RequestHTTPMethod, endpoint: Endpoints) async throws -> Entity where Entity: Decodable
}

enum RequestHTTPMethod {
    case get
    case post
}

final class DefaultNetworkService: NetworkService {
    
    func request<Entity>(method: RequestHTTPMethod, endpoint: Endpoints) async throws -> Entity where Entity: Decodable {
        let result = await AF.request(Endpoints.currencies.rawValue)
            .serializingDecodable(Entity.self)
            .result
        
        switch result {
        case .success(let entity):
            return entity
            
        case .failure(let error):
            throw error
        }
    }
    
}

enum NetworkServiceError: Error {
    case dataNil
    case parseError
}
