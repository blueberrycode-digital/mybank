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
        static let errorLoadingAccountsText = "Error loading accounts"
    }
    
    @Injected
    private var accountsService: AccountsNetworkService
    
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
        do {
            isLoading = true
            let dtos = try await accountsService.load()
            accounts = dtos.map { BankAccountMapper.model(from: $0) }
            isLoading = false
        } catch {
            isLoading = false
            alertMessage = .error(Constants.errorLoadingAccountsText)
        }
    }
    
    func refresh() async {
        do {
            isRefreshing = true
            let dtos = try await accountsService.load()
            accounts = dtos.map { BankAccountMapper.model(from: $0) }
            isRefreshing = false
        } catch {
            isRefreshing = false
            alertMessage = .error(Constants.errorLoadingAccountsText)
        }
    }
    
    init(bankInfo: BankInfo) {
        self.bankInfo = bankInfo
    }
    
}
