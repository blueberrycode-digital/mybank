//
//  CurrencyNetworkService.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation
import Resolver

protocol CurrencyNetworkService {
    func load() async throws -> [CurrencyDto]
}

final class DefaultCurrencyNetworkService: CurrencyNetworkService {
    
    @Injected
    private var networkService: NetworkService
    
    func load() async throws -> [CurrencyDto] {
        try await Task.sleep(nanoseconds: 1/4 * 1_000_000_000)
        
        return [
            CurrencyDto(id: 0, title: "Dollar", shortName: "USD"),
            CurrencyDto(id: 1, title: "Euro", shortName: "EUR")
        ]
    }
    
}
