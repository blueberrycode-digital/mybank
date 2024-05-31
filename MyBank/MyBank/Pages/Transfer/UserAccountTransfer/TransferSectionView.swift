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
    
    // MARK: Private
    
    private func accountNameView(account: BankAccount) -> some View {
        Text(account.name)
            .font(.body)
            .foregroundStyle(.black)
    }
    
    private func amountView(account: BankAccount) -> some View {
        Text("\(String(format: "%.2f", account.amount)) \(account.currency.symbol)")
            .font(.body)
            .foregroundStyle(.black)
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

