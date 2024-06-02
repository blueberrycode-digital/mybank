//
//  LoginView.swift
//  MyBank
//
//  Created by DM (Personal) on 01/06/2024.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    struct Constants {
        static let progressSpacing: CGFloat = 10
        static let padding: CGFloat = 10
    }
    
    @ObservedObject
    private var viewModel: LoginViewModel
    
    // MARK: - Private views
    
    private var startButtonView: some View {
        PrimaryButtonView(title: "Open app")
    }
    
    @ViewBuilder
    private var startButtonLink: some View {
        if let bankInfo = viewModel.bankInfo {
            NavigationLink(destination: MainView(bankInfo: bankInfo)) {
                startButtonView
            }
        } else {
            startButtonView
                .opacity(AppConstants.disabledOpacity)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.progressSpacing) {
                startButtonLink
                ProgressView()
                    .opacity(viewModel.bankInfo == nil ? 1 : 0)
            }.padding(Constants.padding)
        }.task {
            // only first time!!!!!!!
            await viewModel.load()
        }
    }
    
    // MARK: - Init
    
    init() {
        self.viewModel = LoginViewModel()
    }
    
}
