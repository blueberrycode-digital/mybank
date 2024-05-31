//
//  Array+Extension.swift
//  MyFoundation
//
//  Created by DM (Personal) on 30/05/2024.
//

import Foundation

public extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
