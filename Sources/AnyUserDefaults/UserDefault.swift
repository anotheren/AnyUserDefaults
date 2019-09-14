//
//  UserDefault.swift
//  AnyUserDefaults
//
//  Created by 刘栋 on 2019/9/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<KeyStore, Value> where Value: DefaultValue {
    
    public let key: DefaultKey<Value>
    public let defaultValue: Value
    public let adapter: DefaultAdapter<KeyStore>
    public let policy: DefaultPolicy
    
    private var _cachedValue: Value?
    
    private init(key: DefaultKey<Value>, defaultValue: Value, adapter: DefaultAdapter<KeyStore>, policy: DefaultPolicy) {
        self.key = key
        self.defaultValue = defaultValue
        self.adapter = adapter
        self.policy = policy
    }
    
    public init(keyPath: KeyPath<KeyStore, DefaultKey<Value>>, default value: Value, adapter: DefaultAdapter<KeyStore>, policy: DefaultPolicy = []) {
        self.init(key: adapter.keyStore[keyPath: keyPath], defaultValue: value, adapter: adapter, policy: policy)
    }
    
    public var wrappedValue: Value {
        get {
            if policy.contains(.cached), let cachedValue = _cachedValue {
                return cachedValue
            } else {
                return adapter.read(for: key, default: defaultValue)
            }
        }
        set {
            if policy.contains(.cached) {
                _cachedValue = newValue
            }
            adapter.write(value: newValue, for: key)
        }
    }
}

extension UserDefault {
    
    public func remove() {
        adapter.remove(for: key)
    }
}

extension UserDefault where KeyStore == DefaultKeyStore {
    
    public init(keyPath: KeyPath<DefaultKeyStore, DefaultKey<Value>>, default value: Value, policy: DefaultPolicy = []) {
        self.init(keyPath: keyPath, default: value, adapter: AnyDefaultAdapter.standard, policy: policy)
    }
}
