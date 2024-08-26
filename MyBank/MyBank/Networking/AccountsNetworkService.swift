//
//  AccountsNetworkService.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation
import Resolver

protocol AccountsNetworkService {
    func load() async throws -> [BankAccountDto]
}

final class DefaultAccountsNetworkService: AccountsNetworkService {
    
    @Injected
    private var networkService: NetworkService
    
    func load() async throws -> [BankAccountDto] {
        try await Task.sleep(nanoseconds: 1/3 * 1_000_000_000)
        return [
            BankAccountDto(id: 0, amount: 1023.7, currency: 0, name: "My dollar account"),
            BankAccountDto(id: 1, amount: 937, currency: 1, name: "My euro account")
        ]
    }
    
}
