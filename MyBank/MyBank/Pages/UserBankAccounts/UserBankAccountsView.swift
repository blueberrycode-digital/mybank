//
//  UserBankAccountsView.swift
//  MyBank
//
//  Created by DM (Personal) on 11/09/2024.
//

import Foundation
import SwiftUI

struct UserBankAccountsView: View {
    
    private struct Constants {
        static let rowSpacing: CGFloat = 18
        static let dividerSpacing: CGFloat = 5
        static let padding: CGFloat = 15
    }
    
    @ObservedObject
    private var viewModel: UserBankAccountsViewModel
    
    // MARK: - Private
    
    private func rowView(_ account: BankAccount) -> some View {
        VStack(spacing: Constants.dividerSpacing) {
            SingleAccountRow(account: account, allCurrencies: viewModel.bankInfo.currencies)
            Divider()
        }
    }
    
    // MARK: - Views
    
    private var loadedView: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: Constants.rowSpacing) {
                ForEach(viewModel.accounts, id: \.self) { account in
                    rowView(account)
                }
                Spacer()
            }
        }.padding(Constants.padding)
            .refreshable {
                Task {
                    await viewModel.refresh()
                }
            }
    }
    
    var body: some View {
        ZStack {
            loadedView
            if viewModel.isLoading {
                ProgressView()
            }
        }.task {
            await viewModel.load()
        }.customAlert($viewModel.alertMessage)
    }
    
    init(bankInfo: BankInfo) {
        self.viewModel = UserBankAccountsViewModel(bankInfo: bankInfo)
    }
    
}
