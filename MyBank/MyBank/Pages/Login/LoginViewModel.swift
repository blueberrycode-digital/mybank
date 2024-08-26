//
//  LoginViewModel.swift
//  MyBank
//
//  Created by DM (Personal) on 01/06/2024.
//

import Foundation
import Resolver

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published
    private(set) var bankInfo: BankInfo?
    
    // MARK: - Private properties
    
    @Injected
    private var currencyService: CurrencyNetworkService
    
    // MARK: - Internal
    
    func load() async {
        do {
            async let currenciesRequest = loadCurrencies()
            async let exchangeRatesRequest = loadExchangeRates()
            
            let result = try await (currenciesRequest, exchangeRatesRequest)
            bankInfo = BankInfo(currencies: result.0, exchangeRates: result.1)
        } catch {
            // show error
        }
    }
    
    // MARK: - Private
    
    private func loadCurrencies() async throws -> [Currency] {
        let dtos = try await currencyService.load()
        return dtos.map { CurrencyMapper.model(from: $0) }
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
