public final class ObservedProperty<Value>: Property {
	public typealias DidSet = (
		_ oldValue: Value,
		_ value: inout Value
	) -> ()

	public init(
		value: Value,
		didSet: DidSet
	) {
		self.value = value
		self.didSet = didSet
	}

	private let didSet: DidSet

//MARK: Property
	public var value: Value {
		didSet {
			didSet(
				oldValue,
				&value
			)
		}
	}
}

//MARK: public
public extension ObservedProperty {
	convenience init(
		_ observedProperty: ObservedProperty<Value>,
		didSet: DidSet
	) {
		self.init(
			value: observedProperty.value,
			didSet: didSet
		)
	}
}
