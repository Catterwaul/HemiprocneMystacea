import Foundation

public struct Setting
<Value: AnyObject>
{
	public init(
		key: String,
		defaultValue: Value
	) {
		self.key = key
		UserDefaults.standard.register(
			[key: defaultValue]
		)
		UserDefaults.standard.synchronize()
	}
	
	private let key: String
}

//MARK: BooleanLiteralConvertible
public extension Setting where Value: BooleanLiteralConvertible {
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
public extension Setting where Value: IntegerLiteralConvertible {
	var value: Int {
		get {
      return value(getter: UserDefaults.integer(forKey:))
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
private extension Setting {
	///- Returns: **value**
	///- Parameter getter: The method of `NSUserDefaults` that returns a **`Value`**,
	///  when supplied with a key that is a `String`
	func value
  <Value>(
      getter value: (UserDefaults) -> (for: String) -> Value
  ) -> Value {
		return (UserDefaults.standard…value)(for: key)
	}
   
   ///- Returns: The setter for **value**
	///- Parameter setter: The method of `NSUserDefaults` that writes a **`Value`**,
	///  for a key that is a `String`
	func value_set
  <Value>(
    _ value: Value,
		setter set: (UserDefaults) -> (Value, for: String) -> ()
	) {
		(UserDefaults.standard…set)(value, for: self.key)
	}
}
