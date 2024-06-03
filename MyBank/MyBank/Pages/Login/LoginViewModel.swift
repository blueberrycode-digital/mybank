//
//  LoginViewModel.swift
//  MyBank
//
//  Created by DM (Personal) on 01/06/2024.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published
    private(set) var bankInfo: BankInfo?
    
    // MARK: - Internal
    
    func load() async {
        async let currenciesRequest = loadCurrencies()
        async let exchangeRatesRequest = loadExchangeRates()
        
        try? await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        
        let result = await (currenciesRequest, exchangeRatesRequest)
        bankInfo = BankInfo(currencies: result.0, exchangeRates: result.1)
    }
    
    // MARK: - Private
    
    private func loadCurrencies() async -> [Currency] {
        return [
            Currency(id: 0, name: "Dollar", symbol: "USD"),
            Currency(id: 1, name: "EUR", symbol: "EUR")
        ]
    }
    
    private func loadExchangeRates() async -> [ExchangeRate] {
        return [
            ExchangeRate(fromId: 0, toId: 1, value: 0.92)
        ]
    }
    
}

struct BankInfo {
    let currencies: [Currency]
    let exchangeRates: [ExchangeRate]
}
