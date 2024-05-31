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
    
    private struct Constants {
        static let sendSuccessText = "If this were a real app, the money would have been transfered between accounts."
    }
    
    @Published
    private(set) var accounts = [BankAccount]()
    
    @Published
    private(set) var currencies = [Currency]()
    
    @Published
    private(set) var fromAccount: BankAccount?
    
    @Published
    private(set) var toAccount: BankAccount?
    
    @Published
    var alertMessage: AlertMessage = .none
    
    @Published
    var amount = 0.0
    
    @Published
    var selectedCurrency: Currency?// = Currency(id: 1, name: "EUR", symbol: "EUR") //!!!!!!!!!
    
    // MARK: - Internal
    
    func load() async {
        async let accounts: () = loadAccounts()
        async let currencies: () = loadCurrencies()
        
        _ = await (accounts, currencies)
    }
    
    func swap() {
        let toAccountPreviousValue = toAccount
        toAccount = fromAccount
        fromAccount = toAccountPreviousValue
    }
    
    func send() async {
//        guard
        //make sure the account has this amount!!!!!!!!!!!!
        // check faceid
        alertMessage = .info(Constants.sendSuccessText)
        // pop to route
    }
    
    // MARK: - Private
    
    private func loadAccounts() async {
        accounts = [
            BankAccount(id: 0, amount: 1023.7, currency: Currency(id: 0, name: "Dollar", symbol: "USD"), name: "My dollar account"),
            BankAccount(id: 1, amount: 937, currency: Currency(id: 1, name: "EUR", symbol: "EUR"), name: "My euro account")
        ]
        fromAccount = accounts.first
        if let toAccount = accounts[safe: 1] {
            self.toAccount = toAccount
        }
    }
    
    private func loadCurrencies() async {
        currencies = [
            Currency(id: 0, name: "Dollar", symbol: "USD"),
            Currency(id: 1, name: "EUR", symbol: "EUR")
        ]
        
        selectedCurrency = currencies.first
    }
    
}
