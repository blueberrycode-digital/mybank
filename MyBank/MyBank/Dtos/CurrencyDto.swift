//
//  CurrencyDto.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation

struct CurrencyDto: Decodable {
    let id: Int
    let title: String
    let shortName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case shortName = "short-name"
    }
}
