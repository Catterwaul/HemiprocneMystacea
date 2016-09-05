import Foundation

public struct Setting<Value: AnyObject>{
	public init(
		key: String,
		defaultValue: Value
	) {
		self.key = key
		UserDefaults.standard.register(defaults: [key: defaultValue])
		UserDefaults.standard.synchronize()
	}
	
	fileprivate let key: String
}

//MARK: BooleanLiteralConvertible
public extension Setting where Value: ExpressibleByBooleanLiteral {
	var value: Bool {
		get {
			return value(getter: UserDefaults.bool(forKey:))
		}
		set {
			value_set(
				newValue,
				setter: UserDefaults.set
			)
		}
	}
}

//MARK: IntegerLiteralConvertible
public extension Setting where Value: ExpressibleByIntegerLiteral {
	var value: Int {
		get {
			return value(
				getter: UserDefaults.integer(forKey:)
			)
		}
		set {
			value_set(
				newValue,
				setter: UserDefaults.set
			)
		}
	}
}

//MARK: private
fileprivate extension Setting {
	///- Returns: **value**
	///- Parameter getter: The method of `NSUserDefaults` that returns a **`Value`**,
	///  when supplied with a key that is a `String`
	func value<Value>(
		getter value: (UserDefaults) -> (_ for: String) -> Value
	) -> Value {
		return (UserDefaults.standard…value)(key)
	}
   
   ///- Returns: The setter for **value**
	///- Parameter setter: The method of `NSUserDefaults` that writes a **`Value`**,
	///  for a key that is a `String`
	func value_set<Value>(
    _ value: Value,
		setter set: (UserDefaults) -> (Value, _ for: String) -> ()
	) {
		(UserDefaults.standard…set)(value, key)
	}
}
