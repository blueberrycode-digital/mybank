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
    
    @ObservedObject
    private var viewModel: UserAccountTransferViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            TransferSectionView(sectionTitle: "From", account: viewModel.fromAccount)
            swapButton
            TransferSectionView(sectionTitle: "To", account: viewModel.toAccount)
            amountView
            Spacer()
            sendButton
        }.task { // load only once???
            await viewModel.load()
        }.padding(15)
            .customAlert($viewModel.alertMessage)
    }
    
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
    
    private var amountView: some View {
        
    }
    
    init() {
        self.viewModel = UserAccountTransferViewModel()
    }
    
}

private struct SwapButtonView: View {
    
    var body: some View {
        Image(systemName: "rectangle.2.swap")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 35)
    }
    
}
