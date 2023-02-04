//
//  File.swift
//  
//
//  Created by Luke Zhao on 2/4/23.
//

import Foundation

extension FloatingPoint {
    public func rounded(scale: Self, rule: FloatingPointRoundingRule) -> Self {
        (self * scale).rounded(rule) / scale
    }
}
