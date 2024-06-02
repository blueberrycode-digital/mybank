//
//  ContentView.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import SwiftUI

struct MainView: View {
    
    let bankInfo: BankInfo
    
    var body: some View {
        TabView {
            TransferView(bankInfo: bankInfo)
                .tabItem {
                    Image(systemName: "paperplane")
                    Text("Transfer")
                }
        }
    }
    
}
