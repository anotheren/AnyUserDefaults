import XCTest
@testable import AnyUserDefaults

final class AnyUserDefaultsTests: XCTestCase {
    
    @UserDefault(keyPath: \.intKey, default: 110)
    var int: Int
    
    @UserDefault(keyPath: \.floatKey, default: .pi, policy: .cached)
    var float: Float
    
    @UserDefault(keyPath: \.doubleKey, default: .infinity, policy: .cached)
    var double: Double
    
    @UserDefault(keyPath: \.urlKey, default: URL(string: "https://anotheren.com")!)
    var url: URL
    
    @UserDefault(keyPath: \.stringKey, default: "Hello World!")
    var string: String
    
    @UserDefault(keyPath: \.dateKey, default: .init())
    var date: Date
    
    @UserDefault(keyPath: \.dictronaryKey, default: ["Tel": 120])
    var dictronary: [String: Any]
    
    @UserDefault(keyPath: \.codableKey, default: CustomCodable.random())
    var codable: CustomCodable
    
    @UserDefault(keyPath: \.rawRepresentableKey, default: .first)
    var rawRepresentable: CustomRawRepresentable
    
    @UserDefault(keyPath: \.intArrayKey, default: [6, 7, 1, 7, 1, 3, 7, 3, 3, 6, 5, 6, 1, 5])
    var intArray: [Int]
    
    @UserDefault(keyPath: \.floatArrayKey, default: [6, 7, 1, 7, 1, 3, 7, 3, 3, 6, 5, 6, 1, 5])
    var floatArray: [Float]

    @UserDefault(keyPath: \.doubleArrayKey, default: [6, 7, 1, 7, 1, 3, 7, 3, 3, 6, 5, 6, 1, 5])
    var doubleArray: [Double]
    
    @UserDefault(keyPath: \.stringArrayKey, default: ["I", "am", "not", "a", "robot", "!"])
    var stringArray: [String]
    
    @UserDefault(keyPath: \.urlArrayKey, default: [URL(string: "https://www.apple.com")!,
                                                   URL(string: "https://www.apple.com/cn")!,
                                                   URL(string: "https://www.apple.com/hk")!])
    var urlArray: [URL]
    
    @UserDefault(keyPath: \.dateArrayKey, default: [Date(),
                                                    Date(timeIntervalSinceNow: -3600),
                                                    Date(timeIntervalSinceNow: 3600)])
    var dateArray: [Date]
    
    @UserDefault(keyPath: \.codableArrayKey, default: [CustomCodable.random(),
                                                       CustomCodable.random(),
                                                       CustomCodable.random()])
    var codableArray: [CustomCodable]
    
    @UserDefault(keyPath: \.rawRepresentableArrayKey, default: [.first, .second, .third])
    var rawRepresentableArray: [CustomRawRepresentable]
    
    func testInt() {
        _int.remove()
        XCTAssert(int == _int.defaultValue)
        let newValue = Int.random(in: Int.min...Int.max)
        int = newValue
        XCTAssert(int == newValue)
    }
    
    func testFloat() {
        _float.remove()
        XCTAssert(float == _float.defaultValue)
        let newValue = Float.random(in: Float.leastNonzeroMagnitude...Float.greatestFiniteMagnitude)
        float = newValue
        XCTAssert(float == newValue)
    }
    
    func testDouble() {
        _double.remove()
        XCTAssert(double == _double.defaultValue)
        let newValue = Double.random(in: Double.leastNonzeroMagnitude...Double.greatestFiniteMagnitude)
        double = newValue
        XCTAssert(double == newValue)
    }
    
    func testURL() {
        _url.remove()
        XCTAssert(url == _url.defaultValue)
        let newValue = URL(string: "https://www.apple.com/cn")!
        url = newValue
        XCTAssert(url == newValue)
    }
    
    func testString() {
        _string.remove()
        XCTAssert(string == _string.defaultValue)
        let newValue = "https://www.apple.com/cn"
        string = newValue
        XCTAssert(string == newValue)
    }
    
    func testDate() {
        _date.remove()
        XCTAssert(date == _date.defaultValue)
        let newValue = Date()
        date = newValue
        XCTAssert(date == newValue)
    }
    
    func testCodable() {
        _codable.remove()
        XCTAssert(codable == _codable.defaultValue)
        let newValue = CustomCodable.random()
        codable = newValue
        XCTAssert(codable == newValue)
    }
    
    func testRawRepresentable() {
        _rawRepresentable.remove()
        XCTAssert(rawRepresentable == _rawRepresentable.defaultValue)
        let newValue: CustomRawRepresentable = .third
        rawRepresentable = newValue
        XCTAssert(rawRepresentable == newValue)
    }
    
    func testIntArray() {
        _intArray.remove()
        XCTAssert(intArray == _intArray.defaultValue)
        let newValue = (0..<100).map { _ in Int.random(in: Int.min...Int.max) }
        intArray = newValue
        XCTAssert(intArray == newValue)
    }
    
    func testFloatArray() {
        _floatArray.remove()
        XCTAssert(floatArray == _floatArray.defaultValue)
        let newValue = (0..<100).map { _ in Float.random(in: Float.leastNonzeroMagnitude...Float.greatestFiniteMagnitude) }
        floatArray = newValue
        XCTAssert(floatArray == newValue)
    }
    
    func testDoubleArray() {
        _doubleArray.remove()
        XCTAssert(doubleArray == _doubleArray.defaultValue)
        let newValue = (0..<100).map { _ in Double.random(in: Double.leastNonzeroMagnitude...Double.greatestFiniteMagnitude) }
        doubleArray = newValue
        XCTAssert(doubleArray == newValue)
    }
    
    func testStringArray() {
        _stringArray.remove()
        XCTAssert(stringArray == _stringArray.defaultValue)
        var newValue = [String]()
        for _ in 0..<100 {
            if let element = "abcdefghijklmnopqrstuvwxyz".randomElement() {
                newValue.append(String(element))
            }
        }
        stringArray = newValue
        XCTAssert(stringArray == newValue)
    }
    
    func testURLArray() {
        _urlArray.remove()
        XCTAssert(urlArray == _urlArray.defaultValue)
        let newValue = (0..<100).compactMap { URL(string: "https://apple.com/\($0)") }
        urlArray = newValue
        XCTAssert(urlArray == newValue)
    }
    
    func testDateArray() {
        _dateArray.remove()
        XCTAssert(dateArray == _dateArray.defaultValue)
        let newValue = (0..<100).map { Date(timeIntervalSinceNow: 3600.0*Double($0)*pow(-1.0, Double($0))) }
        dateArray = newValue
        XCTAssert(dateArray == newValue)
    }
    
    func testCodableArray() {
        _codableArray.remove()
        XCTAssert(codableArray == _codableArray.defaultValue)
        let newValue = (0..<100).map { _ in CustomCodable.random() }
        codableArray = newValue
        XCTAssert(codableArray == newValue)
    }
    
    func testRawRepresentableArray() {
        _rawRepresentableArray.remove()
        XCTAssert(rawRepresentableArray == _rawRepresentableArray.defaultValue)
        let newValue: [CustomRawRepresentable] = [.third, .second, .first]
        rawRepresentableArray = newValue
        XCTAssert(rawRepresentableArray == newValue)
    }
    
    static var allTests = [
        ("testInt", testInt),
        ("testFloat", testFloat),
        ("testDouble", testDouble),
        ("testURL", testURL),
        ("testString", testString),
        ("testDate", testDate),
        ("testCodable", testCodable),
        
        ("testIntArray", testIntArray),
        ("testFloatArray", testFloatArray),
        ("testDoubleArray", testDoubleArray),
        ("testStringArray", testStringArray),
        ("testURLArray", testURLArray),
        ("testDateArray", testDateArray),
        ("testCodableArray", testCodableArray),
    ]
}

extension DefaultKeyStore {
    
    var intKey: DefaultKey<Int> { .init("int_key") }
    var floatKey: DefaultKey<Float> { .init("float_key") }
    var doubleKey: DefaultKey<Double> { .init("double_key") }
    var urlKey: DefaultKey<URL> { .init("url_key")}
    var stringKey: DefaultKey<String> { .init("string_key") }
    var dateKey: DefaultKey<Date> { .init("date_key") }
    var dictronaryKey: DefaultKey<[String: Any]> { .init("dictronary_key") }
    var codableKey: DefaultKey<CustomCodable> { .init("custom_codable_key") }
    var rawRepresentableKey: DefaultKey<CustomRawRepresentable> { .init("rawrepresentable_key") }
    
    var intArrayKey: DefaultKey<[Int]> { .init("int_array_key") }
    var floatArrayKey: DefaultKey<[Float]> { .init("float_array_key") }
    var doubleArrayKey: DefaultKey<[Double]> { .init("double_array_key") }
    var stringArrayKey: DefaultKey<[String]> { .init("string_array_key") }
    var urlArrayKey: DefaultKey<[URL]> { .init("url_array_key") }
    var dateArrayKey: DefaultKey<[Date]> { .init("date_array_key") }
    var codableArrayKey: DefaultKey<[CustomCodable]> { .init("codable_array_key") }
    var rawRepresentableArrayKey: DefaultKey<[CustomRawRepresentable]> { .init("rawrepresentable_array_key") }
}

struct CustomCodable: Codable, Equatable, DefaultValue, DefaultArrayValue {
    
    let int: Int
    let float: Float
    let double: Double
    let stinrg: String
    
    static func random() -> CustomCodable {
        return CustomCodable(int: Int.random(in: Int.min...Int.max),
                             float: Float.random(in: Float.leastNonzeroMagnitude...Float.greatestFiniteMagnitude),
                             double: Double.random(in: Double.leastNonzeroMagnitude...Double.greatestFiniteMagnitude),
                             stinrg: "Ramdom")
    }
}

enum CustomRawRepresentable: Int, DefaultValue, DefaultArrayValue {
    
    case first
    case second
    case third
}
