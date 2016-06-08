public struct ComputedProperty
<Property> {
	public typealias Get = () -> Property
	public typealias Set = Property -> ()

	public init(
		get: Get,
		set: Set
	) {
		self.get = get
		self.set = set
	}

	public let
	get: Get,
	set: Set
}
public extension ComputedProperty {
	init(
		_ computedProperty: ComputedProperty<Property>,
		get: Get
	) {
		self.get = get
		set = computedProperty.set
	}

	init(
		_ computedProperty: ComputedProperty<Property>,
		set: Set
	) {
		get = computedProperty.get
		self.set = set
	}
}