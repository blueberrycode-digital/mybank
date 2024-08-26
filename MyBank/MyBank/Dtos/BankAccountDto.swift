//
//  BankAccountDto.swift
//  MyBank
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation

struct BankAccountDto: Hashable {
    let id: Int
    let amount: Double
    let currency: Int
    let name: String
}
