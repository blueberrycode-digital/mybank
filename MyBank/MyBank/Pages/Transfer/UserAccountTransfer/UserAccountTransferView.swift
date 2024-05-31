//
//  UserAccountTransferView.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import SwiftUI

struct UserAccountTransferView: View {
    
    @ObservedObject
    private var viewModel: UserAccountTransferViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            Mmmm(sectionTitle: "From", account: viewModel.fromAccount)
            swapButton
            Mmmm(sectionTitle: "To", account: viewModel.toAccount)
            Spacer()
        }.task { // load only once???
            await viewModel.load()
        }
    }
    
    private var swapButton: some View {
        Button(action: {
            viewModel.swap()
        }, label: {
            Image(systemName: "rectangle.2.swap")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35)
        })
    }
    
    init() {
        self.viewModel = UserAccountTransferViewModel()
    }
    
}

struct Mmmm: View {
    
    let sectionTitle: String
    let account: BankAccount?
    
    var body: some View {
        VStack {
            Text(sectionTitle)
                .font(.body)
                .foregroundStyle(.black)
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
