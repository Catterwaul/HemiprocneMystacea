/// A computed property whose getter and setter can change
public struct MutableComputedProperty<Property> {
   public init(get: Get! = nil, set: Set! = nil) {
      self.get = get
      self.set = set
   }

	public var get: Get!, set: Set!
   
   public typealias Get = () -> Property
   public typealias Set = Property -> ()
}

/// A property whose observers can change
public struct MutableObservableProperty<Property> {
   public init(
      value: Property,
      willSet: WillSet? = nil,
      didSet: DidSet? = nil
   ) {
      self.value = value
      self.willSet = willSet
      self.didSet = didSet
   }
   
	public var value: Property {
      willSet {
         willSet?(value: value, newValue: newValue)
      }
      didSet {
         didSet?(oldValue: oldValue, value: &value)
      }
   }
   
   public var willSet: WillSet?, didSet: DidSet?
   
   public typealias WillSet = (value: Property, newValue: Property) -> ()
   public typealias DidSet = (oldValue: Property, inout value: Property) -> ()
}