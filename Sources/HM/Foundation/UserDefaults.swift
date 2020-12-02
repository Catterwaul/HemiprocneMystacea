import Foundation

public extension UserDefaults {
  /// A value that is stored in, and accessed from, `UserDefault`s.
  @propertyWrapper struct Value<WrappedValue: UserDefaults_Value_WrappedValue> {
    public init<Key: CustomStringConvertible>(
      wrappedValue: WrappedValue?,
      key: Key,
      defaults: UserDefaults = .standard
    ) {
      self.key = key.description
      self.defaults = defaults
      self.wrappedValue = wrappedValue
    }

    public var wrappedValue: WrappedValue? {
      get { defaults[key] }
      set { defaults[key] = newValue }
    }

    public let key: String
    private let defaults: UserDefaults
  }

  static subscript<Object: UserDefaults_Value_WrappedValue>(key: String) -> Object? {
    get { standard[key] }
    set { standard[key] = newValue }
  }

  subscript<Object: UserDefaults_Value_WrappedValue>(key: String) -> Object? {
    get { object(forKey: key).flatMap(Object.init)  }
    set { set(newValue?.convertertedToPropertyListObject, forKey: key) }
  }
}

// MARK: - Protocols

public protocol UserDefaults_Value_WrappedValue {
  associatedtype PropertyListObject: HM.PropertyListObject
  init?(propertyListObject: Any)
  var convertertedToPropertyListObject: PropertyListObject { get }
}

public protocol PropertyListObject: UserDefaults_Value_WrappedValue
where PropertyListObject == Self { }

public extension PropertyListObject {
  init?(propertyListObject: Any) {
    guard let object = propertyListObject as? Self
    else { return nil }

    self = object
  }

  var convertertedToPropertyListObject: Self { self }
}

// MARK: - PropertyListObject Types

extension Bool: PropertyListObject { }
extension Data: PropertyListObject { }
extension Date: PropertyListObject { }
extension String: PropertyListObject { }
extension URL: PropertyListObject { }

extension Int: PropertyListObject { }
extension Int8: PropertyListObject { }
extension Int16: PropertyListObject { }
extension Int32: PropertyListObject { }
extension Int64: PropertyListObject { }
extension UInt: PropertyListObject { }
extension UInt8: PropertyListObject { }
extension UInt16: PropertyListObject { }
extension UInt32: PropertyListObject { }
extension UInt64: PropertyListObject { }
extension Float: PropertyListObject { }
extension Double: PropertyListObject { }

extension Array: PropertyListObject & UserDefaults_Value_WrappedValue
where Element: HM.PropertyListObject {
  public typealias PropertyListObject = Self
}

/// A dictionary that is also a valid property-list object.
public typealias PropertyListDictionary<Value: PropertyListObject> = [String: Value]

extension Dictionary: PropertyListObject
where Key == String, Value: HM.PropertyListObject { }

extension Dictionary: UserDefaults_Value_WrappedValue
where Key: LosslessStringConvertible, Value: HM.PropertyListObject {
  public typealias PropertyListObject = PropertyListDictionary<Value>

  public init?(propertyListObject: Any) {
    guard let dictionary = propertyListObject as? PropertyListObject
    else { return nil }

    self.init(dictionary)
  }

  public var convertertedToPropertyListObject: PropertyListObject {
    .init(self)
  }
}

import CoreGraphics
extension CGPoint: PropertyListObject { }
extension CGVector: PropertyListObject { }
extension CGSize: PropertyListObject { }
extension CGRect: PropertyListObject { }
extension CGAffineTransform: PropertyListObject { }
