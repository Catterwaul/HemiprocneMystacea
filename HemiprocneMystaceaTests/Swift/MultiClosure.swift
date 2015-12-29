final class MultiClosure<Input>: EquatableClass {
	/// We can't override () so maybe brackets are the next best thing?
	subscript(input: Input) -> () {
		closures.forEach{$0.reference?[input]}
	}
   
   init(_ closures: EquatableClosure<Input>...) {self += closures}
   
	private var closures = Set<
		WeakReferencer<EquatableClosure<Input>>
	>()
	
	deinit {
		closures.forEach{$0.reference?.multiClosures -= self}
	}
}

final class EquatableClosure<Input>: EquatableClass {
	init(_ closure: Input -> ()) {self.closure = closure}

	subscript(input: Input) -> () {closure(input)}

	private let closure: Input -> ()

	private var multiClosures = Set<
		WeakReferencer<MultiClosure<Input>>
	>()
	
	deinit {
		multiClosures.forEach{$0.reference?.closures -= self}
	}
}

func += <Input>(multiClosure: MultiClosure<Input>, closure: EquatableClosure<Input>) {
   multiClosure.closures += WeakReferencer(closure)
   closure.multiClosures += WeakReferencer(multiClosure)
}

func += <Input>(multiClosure: MultiClosure<Input>, closures: [EquatableClosure<Input>]) {
   for closure in closures {multiClosure += closure}
}

func -= <Input>(multiClosure: MultiClosure<Input>, closure: EquatableClosure<Input>) {
	multiClosure.closures -= closure
	closure.multiClosures -= multiClosure
}