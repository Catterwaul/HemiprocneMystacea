public final class ComputedProperty<Value> {
	public typealias Get = () -> Value
	public typealias Set = (Value) -> Void

	public init(
		get: @escaping Get,
		set: @escaping Set
	) {
		self.get = get
		self.set = set
	}

	private let get: Get
	private let set: Set
}

//MARK: public
public extension ComputedProperty {
	convenience init(
		_ computedProperty: ComputedProperty<Value>,
		get: @escaping Get
	) {
		self.init(
			get: get,
			set: computedProperty.set
		)
	}

	convenience init(
		_ computedProperty: ComputedProperty<Value>,
		set: @escaping Set
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
		get {return get()}
		set {set(newValue)}
	}
}
