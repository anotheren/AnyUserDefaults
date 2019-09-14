//
//  DefaultPolicy.swift
//  AnyUserDefaults
//
//  Created by 刘栋 on 2019/9/11.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public struct DefaultPolicy: OptionSet {
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension DefaultPolicy {
    
    public static let cached = DefaultPolicy(rawValue: 1 << 0)
    
}
