public struct Setting
<Value: AnyObject>
{
	public init(key: String, defaultValue: Value) {
		self.key = key
		NSUserDefaults.standardUserDefaults().registerDefaults(
			[key: defaultValue]
		)
		NSUserDefaults.standardUserDefaults().synchronize()
	}
	
	private let key: String
	
	///- Returns: **value**
	///- Parameter getter: The method of `NSUserDefaults` that returns a **`Value`**,
	///  when supplied with a key that is a `String`
	private func value
  <Value>(
      getter value: NSUserDefaults -> (`for`: String) -> Value
  ) -> Value {
		return (NSUserDefaults.standardUserDefaults()•value)(for: key)
	}
   
   ///- Returns: The setter for **value**
	///- Parameter setter: The method of `NSUserDefaults` that writes a **`Value`**,
	///  for a key that is a `String`
	private func value_set
  <Value>(
    value: Value,
		setter set: NSUserDefaults -> (Value, `for`: String) -> ()
	) {
		(NSUserDefaults.standardUserDefaults()•set)(value, for: self.key)
	}
}

extension Setting where Value: BooleanLiteralConvertible {
	public var value: Bool {
		get {
      return value(getter: NSUserDefaults.boolForKey)
    }
		set {
      value_set(newValue, setter: NSUserDefaults.setBool)
    }
	}
}

extension Setting where Value: IntegerLiteralConvertible {
	public var value: Int {
		get {
      return value(getter: NSUserDefaults.integerForKey)
    }
		set {
      value_set(newValue, setter: NSUserDefaults.setInteger)
    }
	}
}