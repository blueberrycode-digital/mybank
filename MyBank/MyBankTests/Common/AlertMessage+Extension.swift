//
//  AlertMessage+Extension.swift
//  MyBankTests
//
//  Created by DM (Personal) on 02/06/2024.
//

@testable
import MyFoundation

extension AlertMessage {
    
    func isOfType(_ type: AlertMessageType) -> Bool {
        switch type {
        case .none:
            return type == .none
            
        case .info:
            if case .info(_) = self {
                return true
            }
            return false
            
        case .error:
            if case .error(_) = self {
                return true
            }
            return false
        }
    }
    
}

enum AlertMessageType {
    case none
    case info
    case error
}
