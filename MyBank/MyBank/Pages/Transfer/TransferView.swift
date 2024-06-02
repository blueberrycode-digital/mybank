//
//  TransferView.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import SwiftUI

struct TransferView: View {
    
    struct Constants {
        static let spacing: CGFloat = 10
    }
    
    let bankInfo: BankInfo
    
    var body: some View {
        VStack(spacing: Constants.spacing) {
            NavigationLink(destination: UserAccountTransferView(bankInfo: bankInfo)) {
                TransferViewListItem(text: "Between your own accounts")
            }
            
            TransferViewListItem(text: "To another person")
                .disabled(true)
            
            Spacer()
        }
    }
    
}

private struct TransferViewListItem: View {
    
    private struct Constants {
        static let padding = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    }
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    let text: String
    
    private var textView: some View {
        Text(text)
            .foregroundStyle(AppTheme.textColor)
            .font(.title3)
            .opacity(isEnabled ? 1 : AppConstants.disabledOpacity)
    }
    
    var body: some View {
        HStack {
            textView
            Spacer()
        }.padding(Constants.padding)
    }
    
}
