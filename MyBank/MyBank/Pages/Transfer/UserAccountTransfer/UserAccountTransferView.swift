//
//  UserAccountTransferView.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import MyFoundation
import SwiftUI

struct UserAccountTransferView: View {
    
    private struct Constants {
        static let amountSpacing: CGFloat = 12
        static let sectionSpacing: CGFloat = 50
        static let sectionPadding: CGFloat = 15
    }
    
    @ObservedObject
    private var viewModel: UserAccountTransferViewModel
    
    // MARK: - Private views
    
    private var swapButton: some View {
        Button(action: {
            viewModel.swap()
        }, label: {
            SwapButtonView()
        })
    }
    
    private var sendButton: some View {
        Button(action: {
            Task {
                await viewModel.send()
            }
        }, label: {
            PrimaryButtonView(title: "Send")
        })
    }
    
    private var amountSection: some View {
        VStack(spacing: Constants.amountSpacing) {
            TransferSectionHeaderView(title: "Amount")
            amountView
        }
    }
    
    private var amountView: some View {
        HStack {
            amountTextView
            currencySelector
        }
    }
    
    @ViewBuilder
    private var amountTextView: some View {
        TextField("",
                  value: $viewModel.amount,
                  format: .number
        ).textFieldStyle(.plain)
    }
    
    private var currencySelector: some View {
        Picker("", selection: $viewModel.selectedCurrency) {
            ForEach(viewModel.currencies, id: \.self) {
                Text($0.symbol).tag(Optional($0))
            }
        }
        .pickerStyle(.menu)
    }
    
    var body: some View {
        VStack(spacing: Constants.sectionSpacing) {
            TransferSectionView(sectionTitle: "From", account: viewModel.fromAccount, allCurrencies: viewModel.bankInfo.currencies)
            swapButton
            TransferSectionView(sectionTitle: "To", account: viewModel.toAccount, allCurrencies: viewModel.bankInfo.currencies)
            amountSection
            Spacer()
            sendButton
        }
        .task { // load only once???
            await viewModel.load()
        }
        .padding(Constants.sectionPadding)
        .customAlert($viewModel.alertMessage)
    }
    
    // MARK: - Init
    
    init(bankInfo: BankInfo) {
        self.viewModel = UserAccountTransferViewModel(bankInfo: bankInfo)
    }
    
}
