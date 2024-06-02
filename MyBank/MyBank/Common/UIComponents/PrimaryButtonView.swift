//
//  PrimaryButtonView.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import SwiftUI

struct PrimaryButtonView: View {
    
    let title: String
    
    private var titleView: some View {
        Text(title)
            .foregroundStyle(.black)
            .font(.title3)
    }
    
    var body: some View {
        titleView
            .padding(.vertical, 17)
            .frame(maxWidth: .infinity)
            .background(Color.green)
    }
    
}
