//
//  UserAccountTransferViewModelTests.swift
//  MyBankTests
//
//  Created by DM (Personal) on 02/06/2024.
//

@testable import MyBank
import XCTest

final class UserAccountTransferViewModelTests: XCTestCase {
    
    private var viewModel: UserAccountTransferViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        let currencies = [
            Currency(id: 0, name: "aaa", symbol: "a"),
            Currency(id: 1, name: "bbb", symbol: "b")
        ]
        let exchangeRates = [ExchangeRate(fromId: 0, toId: 1, value: 10)]
        let bankInfo = BankInfo(currencies: currencies, exchangeRates: exchangeRates)
        
        viewModel = await UserAccountTransferViewModel(bankInfo: bankInfo)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor
    func testExample() async {
        await viewModel.load()
        
        XCTAssertEqual(viewModel.currencies.count, 2)
        XCTAssertEqual(viewModel.exchangeRates.count, 1)
        XCTAssertEqual(viewModel.selectedCurrency?.id, 0)
        XCTAssertEqual(viewModel.accounts.count, 2)
        XCTAssertEqual(viewModel.fromAccount?.id, 0)
        XCTAssertEqual(viewModel.toAccount?.id, 1)
    }
    
}
