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
	
	fileprivate let key: String
   fileprivate let userDefaults: UserDefaults
}

//MARK: BooleanLiteralConvertible
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

//MARK: IntegerLiteralConvertible
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
