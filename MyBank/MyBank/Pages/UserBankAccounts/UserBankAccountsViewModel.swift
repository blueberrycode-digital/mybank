//
//  UserBankAccountsViewModel.swift
//  MyBank
//
//  Created by DM (Personal) on 11/09/2024.
//

import Foundation
import MyFoundation
import Resolver

@MainActor
final class UserBankAccountsViewModel: ObservableObject {
    
    private struct Constants {
        static let timerDuration: TimeInterval = 5
        //
        static let errorLoadingAccountsText = "Error loading accounts"
    }
    
    @Injected
    private var accountsService: AccountsNetworkService
    
    private var timer: MyTimer?
    
    @Injected
    private var timerCreator: MyTimerCreator
    
    // MARK: - Internal properties
    
    let bankInfo: BankInfo
    
    @Published
    private(set) var accounts = [BankAccount]()
    
    @Published
    private(set) var isLoading = false
    
    @Published
    private(set) var isRefreshing = false
    
    @Published
    var alertMessage: AlertMessage = .none
    
    // MARK: - Internal
    
    func load() async {
        startTimer()
        await loadAccounts()
    }
    
    func refresh() async {
        do {
            isRefreshing = true
            let dtos = try await accountsService.load()
            self.accounts = dtos.map { BankAccountMapper.model(from: $0) }
            isRefreshing = false
        } catch {
            isRefreshing = false
            alertMessage = .error(Constants.errorLoadingAccountsText)
        }
    }
    
    // MARK: - Internal
    
    private func loadAccounts() async {
        do {
            isLoading = true
            let dtos = try await accountsService.load()
            self.accounts = dtos.map { BankAccountMapper.model(from: $0) }
            isLoading = false
        } catch {
            isLoading = false
            alertMessage = .error(Constants.errorLoadingAccountsText)
        }
    }
    
    // Update the USD account every 5 seconds by 5 USD
    private func startTimer() {
        timer?.invalidate()
        timer = timerCreator.createRepeatingTimer(duration: Constants.timerDuration, completion: { [weak self] in // weak self is necessary to avoid the memory leak
            Task { @MainActor [weak self] in
                self?.increaseUsdAccount()
            }
        })
    }
    
    private func increaseUsdAccount() {
        if let usdCurrency = bankInfo.currencies.first(where: { $0.symbol == "USD" }),
           let index = accounts.firstIndex(where: { $0.currency == usdCurrency.id }) {
            let currentAmount = accounts[index].amount
            accounts[index].setAmount(currentAmount + 5)
        }
    }
    
    // MARK: - Init
    
    init(bankInfo: BankInfo) {
        self.bankInfo = bankInfo
    }
    
    deinit {
        timer?.invalidate()
    }
    
}
