//
//  Ex+UserDefaults.swift
//  AnyUserDefaults
//
//  Created by 刘栋 on 2019/9/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    func read<Value>(for key: DefaultKey<Value>) -> Value? where Value: DefaultValue {
        return Value.read(for: key.keyString, userDefaults: self)
    }
    
    func read<Value>(for key: DefaultKey<Value>, default value: Value) -> Value where Value: DefaultValue {
        return Value.read(for: key.keyString, userDefaults: self) ?? value
    }
    
    func write<Value>(value: Value?, for key: DefaultKey<Value>) where Value: DefaultValue {
        Value.write(value: value, for: key.keyString, userDefaults: self)
    }
}

extension UserDefaults {
    
    func has<Value>(for key: DefaultKey<Value>) -> Bool {
        return read(for: key) != nil
    }
    
    func remove<Value>(for key: DefaultKey<Value>) {
        removeObject(forKey: key.keyString)
    }
    
    func removeAll() {
        for (key, _) in dictionaryRepresentation() {
            removeObject(forKey: key)
        }
    }
}
