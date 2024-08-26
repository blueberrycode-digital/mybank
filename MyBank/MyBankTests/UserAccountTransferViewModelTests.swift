//
//  UserAccountTransferViewModelTests.swift
//  MyBankTests
//
//  Created by DM (Personal) on 02/06/2024.
//

@testable import MyBank
import Resolver
import XCTest

final class UserAccountTransferViewModelTests: XCTestCase {
    
    private var viewModel: UserAccountTransferViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let mock = Resolver(child: nil)
        Resolver.root = mock
        
        mock.register {
            MockAccountsNetworkService() as AccountsNetworkService
        }
        
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
    func testLoad_AllPropertiesAreFilled() async {
        await viewModel.load()
        
        XCTAssertEqual(viewModel.currencies.count, 2)
        XCTAssertEqual(viewModel.exchangeRates.count, 1)
        XCTAssertEqual(viewModel.selectedCurrency?.id, 0)
        XCTAssertEqual(viewModel.accounts.count, 2)
        XCTAssertEqual(viewModel.fromAccount?.id, 0)
        XCTAssertEqual(viewModel.toAccount?.id, 1)
    }
    
    @MainActor
    func testSendZeroAmount_ShowError() async {
        await viewModel.load()
        await viewModel.send()
        
        XCTAssertTrue(viewModel.alertMessage.isOfType(.error))
    }
    
    @MainActor
    func testAmountIsMoreThanInSourceAccount_ShowError() async {
        await viewModel.load()
        viewModel.amount = 1_000_000
        
        await viewModel.send()
        
        XCTAssertTrue(viewModel.alertMessage.isOfType(.error))
    }
    
    @MainActor
    func testSwapAmountInSourceAccountCurrency_Success() async {
        await viewModel.load()
        
        XCTAssertEqual(viewModel.fromAccount?.amount, 103)
        XCTAssertEqual(viewModel.toAccount?.amount, 85)
        
        viewModel.amount = 10
        viewModel.selectedCurrency = viewModel.bankInfo.currencies.first(where: { $0.id == viewModel.fromAccount!.currency })
        
        await viewModel.send()
        
        XCTAssertTrue(viewModel.alertMessage.isOfType(.none))
        XCTAssertEqual(viewModel.fromAccount?.amount, 93)
        XCTAssertEqual(viewModel.toAccount?.amount, 185)
    }
    
    @MainActor
    func testSwapAmountInDestinationAccountCurrency_Success() async {
        await viewModel.load()
        
        XCTAssertEqual(viewModel.fromAccount?.amount, 103)
        XCTAssertEqual(viewModel.toAccount?.amount, 85)
        
        viewModel.amount = 10
        viewModel.selectedCurrency = viewModel.bankInfo.currencies.first(where: { $0.id == viewModel.toAccount!.currency })

        await viewModel.send()
        
        XCTAssertTrue(viewModel.alertMessage.isOfType(.none))
        XCTAssertEqual(viewModel.fromAccount?.amount, 102)
        XCTAssertEqual(viewModel.toAccount?.amount, 95)
    }
    
}
