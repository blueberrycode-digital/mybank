//
//  Endpoints.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation

private let baseUrl = "https://firestore.googleapis.com/v1/projects/mybank-e1cab/databases/(default)/documents"

enum Endpoints: String {
    case currencies
    
    private func endpointPath() -> String {
        switch self {
        case .currencies:
            return "/currencies"
        }
    }
    
    var rawValue: String {
        return baseUrl + endpointPath()
    }
}
