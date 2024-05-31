//
//  UserAccountTransferViewModel.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import MyFoundation

@MainActor
final class UserAccountTransferViewModel: ObservableObject {
    
    @Published
    private(set) var accounts = [BankAccount]()
    
    @Published
    private(set) var fromAccount: BankAccount?
    
    @Published
    private(set) var toAccount: BankAccount?
    
    // MARK: - Internal
    
    func load() async {
        accounts = [
            BankAccount(id: 0, amount: 1023.7, currency: Currency(id: 0, name: "Dollar", symbol: "USD"), name: "My dollar account"),
            BankAccount(id: 1, amount: 937, currency: Currency(id: 1, name: "EUR", symbol: "EUR"), name: "My euro account")
        ]
        fromAccount = accounts.first
        if let toAccount = accounts[safe: 1] {
            self.toAccount = toAccount
        }
    }
    
    func swap() {
        let toAccountPreviousValue = toAccount
        toAccount = fromAccount
        fromAccount = toAccountPreviousValue
    }
    
}

struct BankAccount: Hashable {
    let id: Int
    let amount: Double
    let currency: Currency
    let name: String
}

struct Currency: Hashable {
    let id: Int
    let name: String
    let symbol: String
}
