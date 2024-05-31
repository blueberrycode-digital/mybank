//
//  ContentView.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TransferView()
                .tabItem {
                    Image(systemName: "paperplane")
                    Text("Transfer")
                }
        }
    }
}
