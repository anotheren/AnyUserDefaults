//
//  DefaultArrayValue.swift
//  AnyUserDefaults
//
//  Created by 刘栋 on 2019/9/10.
//  Copyright © 2019 anotheren.com. All rights reserved.
//

import Foundation

public protocol DefaultArrayValue {
    
    static func writeArray(value: [Self]?, for key: String, userDefaults: UserDefaults)
    static func readArray(for key: String, userDefaults: UserDefaults) -> [Self]?
}

// MARK: - Int

extension Int: DefaultArrayValue {
    
    public static func writeArray(value: [Int]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Int]? {
        return userDefaults.array(forKey: key) as? [Int]
    }
}

// MARK: - Float

extension Float: DefaultArrayValue {
    
    public static func writeArray(value: [Float]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Float]? {
        return userDefaults.array(forKey: key) as? [Float]
    }
}

// MARK: - Double

extension Double: DefaultArrayValue {
    
    public static func writeArray(value: [Double]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Double]? {
        return userDefaults.array(forKey: key) as? [Double]
    }
}

// MARK: - Bool

extension Bool: DefaultArrayValue {
    
    public static func writeArray(value: [Bool]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Bool]? {
        return userDefaults.array(forKey: key) as? [Bool]
    }
}

// MARK: - String

extension String: DefaultArrayValue {
    
    public static func writeArray(value: [String]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [String]? {
        return userDefaults.array(forKey: key) as? [String]
    }
}

// MARK: - URL

extension URL: DefaultArrayValue {
    
    public static func writeArray(value: [URL]?, for key: String, userDefaults: UserDefaults) {
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
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [URL]? {
        if let data = userDefaults.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Self].self, from: data)
            } catch {
                debugPrint(error)
            }
        }
        return nil
    }
}

// MARK: - Date

extension Date: DefaultArrayValue {
    
    public static func writeArray(value: [Date]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Date]? {
        return userDefaults.array(forKey: key) as? [Date]
    }
}

// MARK: - Data

extension Data: DefaultArrayValue {
    
    public static func writeArray(value: [Data]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Data]? {
        return userDefaults.array(forKey: key) as? [Data]
    }
}

// MARK: - RawRepresentable

extension DefaultArrayValue where Self: RawRepresentable, RawValue: DefaultArrayValue {
    
    public static func writeArray(value: [Self]?, for key: String, userDefaults: UserDefaults) {
        RawValue.writeArray(value: value?.map { $0.rawValue }, for: key, userDefaults: userDefaults)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Self]? {
        return RawValue.readArray(for: key, userDefaults: userDefaults)?.compactMap { Self.init(rawValue: $0) }
    }
}

// MARK: - Codable

extension DefaultArrayValue where Self: Codable {
    
    public static func writeArray(value: [Self]?, for key: String, userDefaults: UserDefaults) {
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
     
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Self]? {
        if let data = userDefaults.data(forKey: key) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([Self].self, from: data)
            } catch {
                debugPrint(error)
            }
        }
        return nil
    }
}
