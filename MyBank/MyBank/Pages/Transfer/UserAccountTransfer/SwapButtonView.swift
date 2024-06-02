//
//  SwapButtonView.swift
//  MyBank
//
//  Created by DM (Personal) on 01/06/2024.
//

import Foundation
import SwiftUI

struct SwapButtonView: View {
    
    private struct Constants {
        static let imageName = "rectangle.2.swap"
        static let width: CGFloat = 35
    }
    
    var body: some View {
        Image(systemName: Constants.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: Constants.width)
    }
    
}
