//
//  LoginView.swift
//  MyBank
//
//  Created by DM (Personal) on 01/06/2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @ObservedObject
    private var viewModel: LoginViewModel
    
    private var startButton: some View {
        Button(action: {
            // go to next page
        }, label: {
            PrimaryButtonView(title: "Open app")
        })
    }
    
    @ViewBuilder
    private var startButtonLink: some View {
        if let bankInfo = viewModel.bankInfo {
            NavigationLink(destination: MainView().environmentObject(bankInfo)) {
                startButton
            }
        } else {
            startButton
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                startButtonLink
                ProgressView()
                    .opacity(viewModel.bankInfo == nil ? 1 : 0)
            }.padding(10)
        }.task {
            // only first time!!!!!!!
            await viewModel.load()
        }
    }
    
    init() {
        self.viewModel = LoginViewModel()
    }
    
}
