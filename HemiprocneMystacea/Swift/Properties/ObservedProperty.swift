public struct ObservedProperty
<Property> {
	public typealias DidSet = (
		oldValue: Property,
		inout value: Property
	) -> ()

	public init(
		value: Property,
		didSet: DidSet
	) {
		self.value = value
		self.didSet = didSet
	}

	public var value: Property {
		didSet {
			didSet(
				oldValue: oldValue,
				value: &value
			)
		}
	}

	private let
	didSet: DidSet
}
public extension ObservedProperty {
	init(
		_ observedProperty: ObservedProperty<Property>,
		didSet: DidSet
	) {
		value = observedProperty.value
		self.didSet = didSet
	}
}