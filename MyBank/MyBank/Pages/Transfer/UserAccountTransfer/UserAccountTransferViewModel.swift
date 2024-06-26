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
        static let insufficientFundsText = "Insufficient funds!"
        static let exchangeRateNotFound = "Exchange rate not found"
        static let amountCantBeZero = "Amount can't be 0"
    }
    
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
    var selectedCurrency: Currency?
    
    @Published
    private(set) var isLoading = false
    
    let bankInfo: BankInfo
    
    // MARK: - Internal
    
    func load() async {
        loadBankInfo(bankInfo)
        isLoading = true
        await loadAccounts()
        isLoading = false
    }
    
    func swap() {
        let toAccountPreviousValue = toAccount
        toAccount = fromAccount
        fromAccount = toAccountPreviousValue
    }
    
    func send() async {
        guard amount != 0 else {
            alertMessage = .error(Constants.amountCantBeZero)
            return
        }
        guard let fromAccount,
              let selectedCurrency else {
            // alert???
            return
        }
        guard let convertedSourceAmount = Self.convertedSourceAmount(fromAccount: fromAccount, selectedCurrency: selectedCurrency, exchangeRates: bankInfo.exchangeRates) else {
            alertMessage = .error(Constants.exchangeRateNotFound)
            // log!!!!!!!
            return
        }
        
        guard amount <= convertedSourceAmount else {
            alertMessage = .error(Constants.insufficientFundsText)
            return
        }
        // check faceid???
        alertMessage = .info(Constants.sendSuccessText)
        // pop to route
    }
    
    // MARK: - Private
    
    private static func convertedSourceAmount(fromAccount: BankAccount, selectedCurrency: Currency, exchangeRates: [ExchangeRate]) -> Double? {
        if fromAccount.currency == selectedCurrency.id {
            return fromAccount.amount
        } else {
            return CurrencyConverter.convert(amount: fromAccount.amount, fromCurrency: fromAccount.currency, toCurrency: selectedCurrency.id, exchangeRates: exchangeRates)
        }
    }
    
    private func loadBankInfo(_ bankInfo: BankInfo) {
        self.currencies = bankInfo.currencies
        self.exchangeRates = bankInfo.exchangeRates
        
        self.selectedCurrency = currencies.first
    }
    
    private func loadAccounts() async {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        accounts = [
            BankAccount(id: 0, amount: 1023.7, currency: 0, name: "My dollar account"),
            BankAccount(id: 1, amount: 937, currency: 1, name: "My euro account")
        ]
        fromAccount = accounts.first
        if let toAccount = accounts[safe: 1] {
            self.toAccount = toAccount
        }
    }
    
    // MARK: - Init
    
    init(bankInfo: BankInfo) {
        self.bankInfo = bankInfo
    }
    
}
