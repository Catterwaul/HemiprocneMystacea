import Foundation

public struct Setting<Value: AnyObject>{
  public init(
    key: String,
    defaultValue: Value,
    userDefaults: UserDefaults = .standard
  ) {
    self.key = key
    self.userDefaults = userDefaults
    userDefaults.register(defaults: [key: defaultValue])
    userDefaults.synchronize()
  }
  
  private let key: String
  private let userDefaults: UserDefaults
}

//MARK: ExpressibleByBooleanLiteral
public extension Setting where Value: ExpressibleByBooleanLiteral {
  var value: Bool {
    get {
      return userDefaults.bool(forKey: key)
    }
    
    set {
      userDefaults.set(newValue, forKey: key)
    }
  }
}

//MARK: ExpressibleByIntegerLiteral
public extension Setting where Value: ExpressibleByIntegerLiteral {
  var value: Int {
    get {
      return userDefaults.integer(forKey: key)
    }
    
    set {
      userDefaults.set(newValue, forKey: key)
    }
  }
}
