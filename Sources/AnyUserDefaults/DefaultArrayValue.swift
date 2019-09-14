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

// MARK: Int

extension Int: DefaultArrayValue {
    
    public static func writeArray(value: [Int]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Int]? {
        return userDefaults.array(forKey: key) as? [Int]
    }
}

// MARK: Float

extension Float: DefaultArrayValue {
    
    public static func writeArray(value: [Float]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Float]? {
        return userDefaults.array(forKey: key) as? [Float]
    }
}

// MARK: Double

extension Double: DefaultArrayValue {
    
    public static func writeArray(value: [Double]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Double]? {
        return userDefaults.array(forKey: key) as? [Double]
    }
}

// MARK: String

extension String: DefaultArrayValue {
    
    public static func writeArray(value: [String]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [String]? {
        return userDefaults.array(forKey: key) as? [String]
    }
}

// MARK: URL

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

// MARK: Date

extension Date: DefaultArrayValue {
    
    public static func writeArray(value: [Date]?, for key: String, userDefaults: UserDefaults) {
        userDefaults.set(value, forKey: key)
    }
    
    public static func readArray(for key: String, userDefaults: UserDefaults) -> [Date]? {
        return userDefaults.array(forKey: key) as? [Date]
    }
}

// MARK: Codable

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
