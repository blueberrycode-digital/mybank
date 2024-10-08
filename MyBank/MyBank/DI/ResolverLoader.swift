//
//  ResolverLoader.swift
//  MyBank
//
//  Created by DM (Personal) on 03/06/2024.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        register { DefaultNetworkService() as NetworkService }
        register { DefaultCurrencyNetworkService() as CurrencyNetworkService }
        register { DefaultAccountsNetworkService() as AccountsNetworkService }
    }
    
}
