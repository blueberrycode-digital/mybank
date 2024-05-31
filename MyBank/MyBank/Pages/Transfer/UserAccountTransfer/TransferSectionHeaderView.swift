//
//  TransferSectionHeaderView.swift
//  MyBank
//
//  Created by DM (Personal) on 31/05/2024.
//

import Foundation
import SwiftUI

struct TransferSectionHeaderView: View {
    
    let title: String
    
    private var titleView: some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.gray)
    }
    
    var body: some View {
        HStack {
            titleView
            Spacer()
        }
    }
    
}
