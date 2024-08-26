//
//  NetworkServices.swift
//  MyBankTests
//
//  Created by DM (Personal) on 26/08/2024.
//

import Foundation
@testable import MyBank

final class MockAccountsNetworkService: AccountsNetworkService {
    
    func load() async throws -> [BankAccountDto] {
        return [
            BankAccountDto(id: 0, amount: 103, currency: 0, name: "My dollar account"),
            BankAccountDto(id: 1, amount: 85, currency: 1, name: "My euro account")
        ]
    }
    
}
