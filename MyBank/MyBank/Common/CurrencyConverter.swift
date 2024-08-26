//
//  CurrencyConverter.swift
//  MyBank
//
//  Created by DM (Personal) on 01/06/2024.
//

import Foundation

final class CurrencyConverter {
    
    static func convert(amount: Double, fromCurrency: Int, toCurrency: Int, exchangeRates: [ExchangeRate]) -> Double? {
        guard fromCurrency != toCurrency else {
            return amount
        }
        
        if let rate = exchangeRates.first(where: { $0.fromId == fromCurrency && $0.toId == toCurrency }) {
            return amount * rate.value
        }
        if let rate = exchangeRates.first(where: { $0.fromId == toCurrency && $0.toId == fromCurrency }) {
            return amount / rate.value
        }
        return nil
    }
    
}
