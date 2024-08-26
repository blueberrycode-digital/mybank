//
//  BankAccountMapper.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation

final class BankAccountMapper {
    
    static func model(from dto: BankAccountDto) -> BankAccount {
        BankAccount(id: dto.id,
                    amount: dto.amount,
                    currency: dto.currency,
                    name: dto.name)
    }
    
}
