public struct ObservedProperty<Property> {
	public typealias WillSet = (
		value: Property,
		newValue: Property
	) -> ()
	public typealias DidSet = (
		oldValue: Property,
		inout value: Property
	) -> ()

	public init(
		value: Property,
		willSet: WillSet = {_, _ in},
		didSet: DidSet = {_, _ in}
	) {
		self.value = value
		self.willSet = willSet
		self.didSet = didSet
	}

	public var value: Property {
		willSet {
			willSet(
				value: value,
				newValue: newValue
			)
		}
		didSet {
			didSet(
				oldValue: oldValue,
				value: &value
			)
		}
	}

	private let
	willSet: WillSet,
	didSet: DidSet
}
public extension ObservedProperty {
	init(
		_ observedProperty: ObservedProperty<Property>,
		didSet: DidSet
	) {
		value = observedProperty.value
		willSet = observedProperty.willSet
		self.didSet = didSet
	}
}