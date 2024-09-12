//
//  UserBankAccountTransferViewModel.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import MyFoundation
import Resolver

@MainActor
final class UserBankAccountTransferViewModel: ObservableObject {
    
    private struct Constants {
        static let unableToLoadDataText = "Unable to load data"
        static let insufficientFundsText = "Insufficient funds"
        static let exchangeRateNotFoundText = "Exchange rate not found"
        static let amountCantBeZeroText = "Amount can't be 0"
        static let errorLoadingAccountsText = "Error loading accounts"
        static let updateSuccessful = "Update successful"
    }
    
    @Injected
    private var accountsService: AccountsNetworkService
    
    // MARK: - Internal properties
    
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
            alertMessage = .error(Constants.amountCantBeZeroText)
            return
        }
        guard let fromAccount,
              let toAccount,
              let selectedCurrency else {
            alertMessage = .error(Constants.unableToLoadDataText)
            return
        }
        guard let amountInSourceAccountCurrency = CurrencyConverter.convert(amount: amount, fromCurrency: selectedCurrency.id, toCurrency: fromAccount.currency, exchangeRates: exchangeRates),
              let amountInDestinationAccountCurrency = CurrencyConverter.convert(amount: amount, fromCurrency: selectedCurrency.id, toCurrency: toAccount.currency, exchangeRates: exchangeRates) else {
            alertMessage = .error(Constants.exchangeRateNotFoundText)
            return
        }
        
        guard amountInSourceAccountCurrency <= fromAccount.amount else {
            alertMessage = .error(Constants.insufficientFundsText)
            return
        }
        
        let updatedFromAmount = fromAccount.amount - amountInSourceAccountCurrency
        let updatedToAmount = toAccount.amount + amountInDestinationAccountCurrency
        
        self.fromAccount?.setAmount(updatedFromAmount)
        self.toAccount?.setAmount(updatedToAmount)
        
        alertMessage = .info(Constants.updateSuccessful)
    }
    
    // MARK: - Private
    
    private func loadBankInfo(_ bankInfo: BankInfo) {
        self.currencies = bankInfo.currencies
        self.exchangeRates = bankInfo.exchangeRates
        
        self.selectedCurrency = currencies.first
    }
    
    private func loadAccounts() async {
        do {
            let dtos = try await accountsService.load()
            accounts = dtos.map { BankAccountMapper.model(from: $0) }
            fromAccount = accounts.first
            if let toAccount = accounts[safe: 1] {
                self.toAccount = toAccount
            }
        } catch {
            alertMessage = .error(Constants.errorLoadingAccountsText)
        }
    }
    
    // MARK: - Init
    
    init(bankInfo: BankInfo) {
        self.bankInfo = bankInfo
    }
    
}
