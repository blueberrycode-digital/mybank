//
//  UserAccountTransferViewModel.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import MyFoundation
import struct SwiftUI.EnvironmentObject

@MainActor
final class UserAccountTransferViewModel: ObservableObject {
    
    private struct Constants {
        static let sendSuccessText = "If this were a real app, the money would have been transfered between accounts."
        static let insufficientFundsText = "Insufficient funds!"
    }
    
    @EnvironmentObject private var bankInfo: BankInfo
    
    @Published
    private(set) var accounts = [BankAccount]()
    
    @Published
    private(set) var currencies = [Currency]()
    
    @Published
    private(set) var exchangeRates = [ExchangeRate]()
    
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
        await loadAccounts()
    }
    
    func swap() {
        let toAccountPreviousValue = toAccount
        toAccount = fromAccount
        fromAccount = toAccountPreviousValue
    }
    
    func send() async {
        guard let fromAccount,
              let selectedCurrency else {
            return
        }
        let convertedFromAmount: Double
        if fromAccount.currency == selectedCurrency {
            convertedFromAmount = fromAccount.amount
        } else {
            convertedFromAmount = CurrencyConverter.convert(amount: fromAccount.amount, fromCurrency: fromAccount.currency, toCurrency: selectedCurrency)
        }
        guard amount <= convertedFromAmount else {
            alertMessage = .error(Constants.insufficientFundsText)
            return
        }
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
    
    //
    
    init() {
        self.currencies = bankInfo.currencies
        self.exchangeRates = bankInfo.exchangeRates
        
        self.selectedCurrency = currencies.first
    }
    
}
