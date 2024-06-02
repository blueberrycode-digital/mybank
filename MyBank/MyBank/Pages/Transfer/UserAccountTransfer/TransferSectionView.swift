//
//  TransferSectionView.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import SwiftUI

struct TransferSectionView: View {
    
    let sectionTitle: String
    let account: BankAccount?
    let allCurrencies: [Currency]
    
    // MARK: Private
    
    private func accountNameView(account: BankAccount) -> some View {
        Text(account.name)
            .font(.body)
            .foregroundStyle(AppTheme.textColor)
    }
    
    private static func formattedAmount(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
    
    private func currencySymbol(forId currencyId: Int) -> String {
        allCurrencies.first(where: { $0.id == currencyId })?.symbol ?? "--"
    }
    
    private func amountView(account: BankAccount) -> some View {
        Text("\(Self.formattedAmount(account.amount)) \(currencySymbol(forId: account.currency))")
            .font(.body)
            .foregroundStyle(AppTheme.textColor)
    }
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            TransferSectionHeaderView(title: sectionTitle)
            if let account {
                HStack {
                    accountNameView(account: account)
                    Spacer()
                    amountView(account: account)
                }
            }
        }
    }
    
}

