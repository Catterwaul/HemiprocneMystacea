import Foundation

public extension UserDefaults {
  static subscript(key: String) -> Bool? {
    get { standard.bool(forKey: key) }
    set { standard.set(newValue, forKey: key) }
  }

  static subscript(key: String) -> Int? {
    get { standard.integer(forKey: key) }
    set { standard.set(newValue, forKey: key) }
  }

  static subscript<Key: LosslessStringConvertible, Value>(key: String) -> [Key: Value]? {
    get {
      (standard.dictionary(forKey: key) as? [String: Value])?
        .compactMapKeys(Key.init)
    }
    set {
      standard.set(newValue?.mapKeys(\.description), forKey: key)
    }
  }
}
