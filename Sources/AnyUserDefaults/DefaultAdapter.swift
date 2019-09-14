//
//  DefaultAdapter.swift
//  AnyUserDefaults
//
//  Created by 刘栋 on 2019/9/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public class DefaultAdapter<KeyStore> {
    
    public var keyStore: KeyStore
    public var userDefaults: UserDefaults
    
    public init(keyStore: KeyStore, userDefaults: UserDefaults) {
        self.keyStore = keyStore
        self.userDefaults = userDefaults
    }
}

// MARK: - Read & Write

extension DefaultAdapter {
    
    func read<Value>(for key: DefaultKey<Value>) -> Value? where Value: DefaultValue {
        return userDefaults.read(for: key)
    }
    
    func read<Value>(for key: DefaultKey<Value>, default value: Value) -> Value where Value: DefaultValue {
        return userDefaults.read(for: key, default: value)
    }
    
    func write<Value>(value: Value?, for key: DefaultKey<Value>) where Value: DefaultValue {
        userDefaults.write(value: value, for: key)
    }
    
    public func read<Value>(at keyPath: KeyPath<KeyStore, DefaultKey<Value>>) -> Value? where Value: DefaultValue {
        return read(for: keyStore[keyPath: keyPath])
    }
    
    public func read<Value>(at keyPath: KeyPath<KeyStore, DefaultKey<Value>>, default value: Value) -> Value where Value: DefaultValue {
        return read(for: keyStore[keyPath: keyPath], default: value)
    }
    
    public func write<Value>(value: Value?, at keyPath: KeyPath<KeyStore, DefaultKey<Value>>) where Value: DefaultValue {
        write(value: value, for: keyStore[keyPath: keyPath])
    }
}

// MARK: - Helper

extension DefaultAdapter {
    
    func has<Value>(for key: DefaultKey<Value>) -> Bool where Value: DefaultValue {
        return userDefaults.has(for: key)
    }
    
    func remove<Value>(for key: DefaultKey<Value>) where Value: DefaultValue {
        userDefaults.remove(for: key)
    }
    
    public func has<Value>(at keyPath: KeyPath<KeyStore, DefaultKey<Value>>) -> Bool where Value: DefaultValue {
        return has(for: keyStore[keyPath: keyPath])
    }
    
    public func remove<Value>(at keyPath: KeyPath<KeyStore, DefaultKey<Value>>) {
        remove(for: keyStore[keyPath: keyPath])
    }
    
    public func removeAll() {
        userDefaults.removeAll()
    }
}

// MARK: - Subscript for KeyPath

extension DefaultAdapter {
    
    public subscript<Value>(keyPath: KeyPath<KeyStore, DefaultKey<Value>>) -> Value? where Value: DefaultValue {
        get { read(at: keyPath) }
        set { write(value: newValue, at: keyPath) }
    }
}

// MARK: - AnyDefaultAdapter

public typealias AnyDefaultAdapter = DefaultAdapter<DefaultKeyStore>

extension AnyDefaultAdapter {
    
    public static let standard = AnyDefaultAdapter(keyStore: DefaultKeyStore(), userDefaults: .standard)
}
