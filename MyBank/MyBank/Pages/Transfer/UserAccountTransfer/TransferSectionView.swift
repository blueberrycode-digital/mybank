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
    
    private var titleView: some View {
        Text(sectionTitle)
            .font(.body)
            .foregroundStyle(.black)
    }
    
    var body: some View {
        VStack {
            titleView
            if let account {
                HStack {
                    Text(account.name)
                    Spacer()
                    Text("\(String(format: "%.2f", account.amount)) \(account.currency.symbol)")
                }
            }
        }
    }
    
}

