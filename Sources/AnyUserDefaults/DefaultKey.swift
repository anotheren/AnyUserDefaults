//
//  DefaultKey.swift
//  AnyUserDefaults
//
//  Created by 刘栋 on 2019/9/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public struct DefaultKey<Value> where Value: DefaultValue {
    
    public let keyString: String
    
    public init(_ string: String) {
        self.keyString = string
    }
}
