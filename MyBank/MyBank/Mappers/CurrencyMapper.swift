//
//  CurrencyMapper.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation

final class CurrencyMapper {
    
    static func model(from dto: CurrencyDto) -> Currency {
        Currency(id: dto.id, name: dto.title, symbol: dto.shortName)
    }
    
}
