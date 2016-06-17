public final class ComputedProperty
<Value>
{
	public typealias Get = () -> Value
	public typealias Set = (Value) -> ()

	public init(
		get: Get,
		set: Set
	) {
		self.get = get
		self.set = set
	}

	private let
	get: Get,
	set: Set
}

//MARK: public
public extension ComputedProperty {
	convenience init(
		_ computedProperty: ComputedProperty<Value>,
		get: Get
	) {
		self.init(
			get: get,
			set: computedProperty.set
		)
	}

	convenience init(
		_ computedProperty: ComputedProperty<Value>,
		set: Set
	) {
		self.init(
			get: computedProperty.get,
			set: set
		)
	}
}

//MARK: Property
extension ComputedProperty: Property {
	public var value: Value {
		get {
			return get()
		}
		set {
			set(newValue)
		}
	}
}
