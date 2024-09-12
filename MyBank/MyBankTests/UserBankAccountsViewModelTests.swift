//
//  UserBankAccountsViewModelTests.swift
//  MyBankTests
//
//  Created by DM (Personal) on 02/06/2024.
//

@testable import MyBank
import MyFoundation
import Resolver
import XCTest

final class UserBankAccountsViewModelTests: XCTestCase {
    
    private var viewModel: UserBankAccountsViewModel!
    
    private var timerCreator: MockMyTimerCreator!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mock = Resolver(child: nil)
        Resolver.root = mock
        
        timerCreator = MockMyTimerCreator()
        
        mock.register {
            MockAccountsNetworkService() as AccountsNetworkService
        }
        mock.register {
            self.timerCreator as MyTimerCreator
        }
        
        let currencies = [
            Currency(id: 0, name: "aaa", symbol: "a"),
            Currency(id: 1, name: "bbb", symbol: "b")
        ]
        let exchangeRates = [ExchangeRate(fromId: 0, toId: 1, value: 10)]
        let bankInfo = BankInfo(currencies: currencies, exchangeRates: exchangeRates)
        
        viewModel = await UserBankAccountsViewModel(bankInfo: bankInfo)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    @MainActor
    func testLoad_AllPropertiesAreFilled() async {
        await viewModel.load()
        
        XCTAssertEqual(viewModel.accounts.count, 2)
        XCTAssertEqual(timerCreator.timers.count, 1)
        XCTAssertTrue(timerCreator.timers.first!.isValid)
    }
    
}
