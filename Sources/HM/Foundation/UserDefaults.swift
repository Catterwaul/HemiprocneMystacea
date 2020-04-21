import Foundation

public extension UserDefaults {
//MARK:- static

  static subscript<Object: PropertyListObject>(key: String) -> Object? {
    get { standard[key] }
    set { standard[key] = newValue }
  }

  static subscript<
    Key: LosslessStringConvertible, Value: PropertyListObject
  >(key: String) -> [Key: Value]? {
    standard[key]
  }

//MARK:- instance

  subscript<Object: PropertyListObject>(key: String) -> Object? {
    get { object(forKey: key) as? Object }
    set { set(newValue, forKey: key) }
  }

  subscript<
    Key: LosslessStringConvertible, Value: PropertyListObject
  >(key: String) -> [Key: Value]? {
    (dictionary(forKey: key) as? PropertyListDictionary)
    .map(Dictionary.init)
  }
}

public protocol PropertyListObject { }

extension Bool: PropertyListObject { }
extension Data: PropertyListObject { }
extension Date: PropertyListObject { }
extension String: PropertyListObject { }
extension URL: PropertyListObject { }

extension Int8: PropertyListObject { }
extension Int16: PropertyListObject { }
extension Int32: PropertyListObject { }
extension Int64: PropertyListObject { }
extension UInt8: PropertyListObject { }
extension UInt16: PropertyListObject { }
extension UInt32: PropertyListObject { }
extension UInt64: PropertyListObject { }
extension Float: PropertyListObject { }
extension Double: PropertyListObject { }

extension Array: PropertyListObject where Element: PropertyListObject { }

public typealias PropertyListDictionary<Value: PropertyListObject> = [String: Value]

extension PropertyListDictionary: PropertyListObject
where Key == String, Value: PropertyListObject {
  public init<Key: LosslessStringConvertible>(_ dictionary: [Key: Value]) {
    self = dictionary.mapKeys(\.description)
  }
}

import CoreGraphics
extension CGPoint: PropertyListObject { }
extension CGVector: PropertyListObject { }
extension CGSize: PropertyListObject { }
extension CGRect: PropertyListObject { }
extension CGAffineTransform: PropertyListObject { }
