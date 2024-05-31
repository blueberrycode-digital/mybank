//
//  BankAccount.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation

struct BankAccount: Hashable {
    let id: Int
    let amount: Double
    let currency: Currency
    let name: String
}

struct Currency: Hashable {
    let id: Int
    let name: String
    let symbol: String
}
