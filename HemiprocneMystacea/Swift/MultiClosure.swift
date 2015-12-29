public final class MultiClosure<Input>: EquatableClass {
	/// We can't override () so maybe brackets are the next best thing?
	public subscript(input: Input) -> () {
		closures.forEach{$0.reference?[input]}
	}
   
   public init(_ closures: EquatableClosure<Input>...) {self += closures}
   
	private var closures = Set<
		WeakReferencer<EquatableClosure<Input>>
	>()
	
	deinit {
		closures.forEach{$0.reference?.multiClosures -= self}
	}
}

public final class EquatableClosure<Input>: EquatableClass {
	public init(_ closure: Input -> ()) {self.closure = closure}

	public subscript(input: Input) -> () {closure(input)}

	private let closure: Input -> ()

	private var multiClosures = Set<
		WeakReferencer<MultiClosure<Input>>
	>()
	
	deinit {
		multiClosures.forEach{$0.reference?.closures -= self}
	}
}

public func += <Input>(
   multiClosure: MultiClosure<Input>,
   closure: EquatableClosure<Input>
) {
   multiClosure.closures += WeakReferencer(closure)
   closure.multiClosures += WeakReferencer(multiClosure)
}

public func += <Input>(
   multiClosure: MultiClosure<Input>,
   closures: [EquatableClosure<Input>]
) {
   for closure in closures {multiClosure += closure}
}

public func -= <Input>(
   multiClosure: MultiClosure<Input>,
   closure: EquatableClosure<Input>
) {
	multiClosure.closures -= closure
	closure.multiClosures -= multiClosure
}