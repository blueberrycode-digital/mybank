//
//  ExchangeRate.swift
//  MyBank
//
//  Created by DM (Personal) on 01/06/2024.
//

import Foundation

struct ExchangeRate: Hashable {
    let fromId: Int
    let toId: Int
    let value: Double
}
