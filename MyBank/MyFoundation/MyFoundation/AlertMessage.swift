//
//  AlertMessage.swift
//  MyFoundation
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation
import SwiftUI

public enum AlertMessage: Equatable {
    case none
    case info(String)
    case error(String)
}

struct CustomAlertModifier: ViewModifier {
    @Binding var message: AlertMessage
    
    private var isPresented: Binding<Bool> {
        Binding {
            message != .none
        } set: { value in
            if !value {
                message = .none
            }
        }
    }
    
    func body(content: Content) -> some View {
        content.alert(isPresented: isPresented) {
            switch message {
            case .none:
                Alert(
                    title: Text(""),
                    message: Text(""),
                    dismissButton: .default(Text("OK"))
                )
                
            case .info(let string):
                Alert(
                    title: Text("Alert"),
                    message: Text(string),
                    dismissButton: .default(Text("OK"))
                )
                
            case .error(let string):
                Alert(
                    title: Text("Alert"),
                    message: Text(string),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

public extension View {
    func customAlert(_ message: Binding<AlertMessage>) -> some View {
        self.modifier(CustomAlertModifier(message: message))
    }
}
