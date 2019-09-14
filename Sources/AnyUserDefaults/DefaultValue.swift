//
//  DefaultValue.swift
//  AnyUserDefaults
//
//  Created by 刘栋 on 2019/9/9.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public protocol DefaultValue {
    
    static func write(value: Self?, for key: String, userDefaults: UserDefaults)
    static func read(for key: String, userDefaults: UserDefaults) -> Self?
}

// MARK: - Int

extension Int: DefaultValue {

    public static func write(value: Int?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> Int? {
        return userDefaults.object(forKey: key) as? Int
    }
}

// MARK: - Float

extension Float: DefaultValue {

    public static func write(value: Float?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> Float? {
        return userDefaults.object(forKey: key) as? Float
    }
}

// MARK: - Double

extension Double: DefaultValue {

    public static func write(value: Double?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> Double? {
        return userDefaults.object(forKey: key) as? Double
    }
}

// MARK: - String

extension String: DefaultValue {

    public static func write(value: String?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> String? {
        return userDefaults.string(forKey: key)
    }
}

// MARK: - URL

extension URL: DefaultValue {

    public static func write(value: URL?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> URL? {
        return userDefaults.url(forKey: key)
    }
}

// MARK: - Date

extension Date: DefaultValue {
    
    public static func write(value: Date?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> Date? {
        return userDefaults.object(forKey: key) as? Date
    }
}

// MARK: - Dictionary

extension Dictionary: DefaultValue where Key == String, Value == Any {
    
    public static func write(value: [String: Any]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func read(for key: String, userDefaults: UserDefaults) -> [String: Any]? {
        return userDefaults.dictionary(forKey: key)
    }
}

// MARK: - Array

extension Array: DefaultValue where Element: DefaultArrayValue {

    public static func write(value: [Element]?, for key: String, userDefaults: UserDefaults) {
        Element.writeArray(value: value, for: key, userDefaults: userDefaults)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> [Element]? {
        return Element.readArray(for: key, userDefaults: userDefaults)
    }
}

// MARK: - RawRepresentable

extension DefaultValue where Self: RawRepresentable, RawValue: DefaultValue {
    
    public static func write(value: Self?, for key: String, userDefaults: UserDefaults) {
        RawValue.write(value: value?.rawValue, for: key, userDefaults: userDefaults)
    }

    public static func read(for key: String, userDefaults: UserDefaults) -> Self? {
        if let rawValue =  RawValue.read(for: key, userDefaults: userDefaults) {
            return Self(rawValue: rawValue)
        }
        return nil
    }
}

// MARK: - Codable

extension DefaultValue where Self: Codable {
    
    public static func write(value: Self?, for key: String, userDefaults: UserDefaults) {
        if let value = value {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(value)
                userDefaults.set(data, forKey: key)
            } catch {
                debugPrint(error)
            }
        } else {
            userDefaults.removeObject(forKey: key)
        }
    }
    
    public static func read(for key: String, userDefaults: UserDefaults) -> Self? {
        if let data = userDefaults.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode(Self.self, from: data)
            } catch {
                debugPrint(error)
            }
        }
        return nil
    }
}
