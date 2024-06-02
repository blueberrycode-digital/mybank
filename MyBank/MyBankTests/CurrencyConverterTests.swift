//
//  CurrencyConverterTests.swift
//  MyBankTests
//
//  Created by DM (Personal) on 30/05/2024.
//

import XCTest
@testable import MyBank

final class CurrencyConverterTests: XCTestCase {
    
    func testConvertingFromAtoB() {
        let exchangeRates = [
            ExchangeRate(fromId: 0, toId: 1, value: 1000)
        ]
        let convertedAmount = CurrencyConverter.convert(amount: 2, fromCurrency: 0, toCurrency: 1, exchangeRates: exchangeRates)
        
        XCTAssertEqual(convertedAmount, 2000)
    }
    
    func testConvertingFromBtoA() {
        let exchangeRates = [
            ExchangeRate(fromId: 0, toId: 1, value: 1000)
        ]
        let convertedAmount = CurrencyConverter.convert(amount: 3000, fromCurrency: 1, toCurrency: 0, exchangeRates: exchangeRates)
        
        XCTAssertEqual(convertedAmount, 3)
    }
    
    func testNoExchangeRateFound() {
        let exchangeRates = [
            ExchangeRate(fromId: 0, toId: 1, value: 1)
        ]
        let convertedAmount = CurrencyConverter.convert(amount: 1, fromCurrency: 0, toCurrency: 3, exchangeRates: exchangeRates)
        
        XCTAssertEqual(convertedAmount, nil)
    }
    
}
