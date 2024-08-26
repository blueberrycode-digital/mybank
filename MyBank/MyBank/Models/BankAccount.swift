//
//  BankAccount.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation

struct BankAccount: Hashable {
    let id: Int
    private(set) var amount: Double
    let currency: Int
    let name: String
    
    mutating func setAmount(_ amount: Double) {
        self.amount = amount
    }
}
