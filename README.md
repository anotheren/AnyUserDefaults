# AnyUserDefaults

AnyUserDefaults is a Morden UserDefaults wapper for Swift. Especially the [`propertyWrapper`](https://github.com/apple/swift-evolution/blob/master/proposals/0258-property-wrappers.md) will make your code more clear.

## Requirements

- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 11+
- Swift 5.1+

## Usage

### Basic Usage

You can just extension `DefaultKeyStore` as Default KeyStore

```swift
extension DefaultKeyStore {
    
    var usernameKey: DefaultKey<String> { .init("username_key") }

    var passwordKey: DefaultKey<String> { .init("password_key") }
}
```

Then, use `@UserDefault` to bind your property to UserDefaults, which will auto **Read**, **Write**, or do some **Type Check**

```swift
class LoginViewController: UIViewController {

    @UserDefault(keyPath: \DefaultKeyStore.usernameKey, default: "Admin")
    var userName: String

    @UserDefault(keyPath: \DefaultKeyStore.passwordKey, default: "12345678")
    var password: String
}
```

### Advanced Usage

When you want to use your custom KeyStore instand of default one, or want to share UseDefaults Data between main applicaiotn and application extensions

Create your custom KeyStore first

```swift
struct CustomKeyStore {

    var lastLaunchDateKey: DefaultKey<Date> { .init("last_launch_date_key") }
}
```

Create your custom DefaultAdaptor

```swift
typealias CustomDefaultAdapter = DefaultAdapter<CustomKeyStore>

extension CustomDefaultAdapter {
    
    static let shared = CustomDefaultAdapter(keyStore: CustomKeyStore(), userDefaults: UserDefaults(suiteName: "YOUR_APP_GROUP_NAME"!)
}
```

Create UserDefault extension for your `CustomKeyStore`

```swift
extension UserDefault where KeyStore == CustomKeyStore {
    
    init(keyPath: KeyPath<CustomKeyStore, DefaultKey<Value>>, default value: Value, policy: DefaultPolicy = []) {
        self.init(keyPath: keyPath, default: value, adapter: CustomDefaultAdapter.shared, policy: policy)
    }
}
```

Use your `CustomKeyStore` to bind your property
```swift
class SomeViewController: UIViewController {

    @UserDefault(keyPath: \CustomKeyStore.lastLaunchDateKey, default: Date())
    var lastLaunchDate: Date
}
```

### DefaultValue Type

Use `DefaultValue` protocol for single value, and use `DefaultArrayValue` protocol for array value. AnyUserDefaults supports all of the standard UserDefaults types.

| Single Value |  Array Value | where |
| ------------ | ------------ | ----- |
| Int          | [Int]        |       |
| Float        | [Float]      |       |
| Double       | [Double]     |       |
| Bool         | [Bool]       |       |
| Date         | [Date]       |       |
| URL          | [URL]        |       |
| Data         | [Data]       |       |
| [String: Any]|              |       |
| Codable      | [Codable]    |       |
| RawRepresentable| [RawRepresentable]| RawValue: DefaultValue |

Custom Codable Type Example:
```
struct MyCodableType: Codable, DefaultArrayValue {

    var a: Int
    var b: [String]
}
```

Custom RawRepresentable Type Example:
```
enum MyRawRepresentableType: Int, DefaultValue {

    case first
    case second
    case third
}
```

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate AnyUserDefaults into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'AnyUserDefaults', '~> 1.0.1'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate AnyUserDefaults into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "anotheren/AnyUserDefaults", '~> 1.0.1'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the swift compiler. 

Once you have your Swift package set up, adding AnyUserDefaults as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/anotheren/AnyUserDefaults.git", from: "1.0.1")
]
```

## License

AnyUserDefaults is released under the MIT license. See [LICENSE](./LICENSE) for details.
