/// A workaround for Swift not providing a way to remove closures
/// from a collection of closures.
///- Note: Designed for one-to-many events, hence no return value.
///  Returning a single value from multiple closures doesn't make sense.
public final class MultiClosure<Input>: EquatableClass {
	public init(_ closures: EquatableClosure<Input>...) {
		self += closures
	}
	
	public init<Closures: Sequence>
	(_ closures: Closures)
	where Closures.Iterator.Element == EquatableClosure<Input>
	{self += closures}
	
	/// Execute every closure
	///
	/// ***Rationale:***
	/// We can't override () so maybe brackets are the next best thing?
	public subscript(input: Input) -> () {
		closures.forEach{$0.reference[input]}
	}
	
	var closures = Set<
		UnownedReferencer< EquatableClosure<Input> >
	>()
	
//MARK: deallocation
	// We can't find self in `closures` without this.
	fileprivate lazy var unownedSelf: UnownedReferencer< MultiClosure<Input> >
		= UnownedReferencer(self)
	
	// Even though this MultiClosure will be deallocated,
	// its corresponding WeakReferencers won't be,
	// unless we take this manual action or similar.
	deinit {
		closures.forEach{$0.reference.multiClosures -= unownedSelf}
	}
}

/// A wrapper around a closure, for use with MultiClosures
public final class EquatableClosure<Input>: EquatableClass {
	public init( _ closure: @escaping (Input) -> () ) {
		self.closure = closure
	}

	/// Execute the closure
	///
	/// ***Rationale:***
	/// We can't override () so maybe brackets are the next best thing?
	public subscript(input: Input) -> Void {
		closure(input)
	}
	
	private let closure: (Input) -> ()

//MARK: deallocation
	var multiClosures: Set<
		UnownedReferencer< MultiClosure<Input> >
	> = []
	
	// We can't find self in `multiClosures` without this.
	fileprivate lazy var unownedSelf: UnownedReferencer<
		EquatableClosure<Input>
	> = UnownedReferencer(self)
	
	deinit {
		multiClosures.forEach{$0.reference.closures -= unownedSelf}
	}
}

/// Add `closure` to the set of closures that runs
/// when `multiClosure` does
public func += <Input>(
   multiClosure: MultiClosure<Input>,
   closure: EquatableClosure<Input>
) {
   multiClosure.closures += closure.unownedSelf
   closure.multiClosures += multiClosure.unownedSelf
}

/// Add `closures` to the set of closures that runs
/// when `multiClosure` does
public func += <
   Input,
   Closures: Sequence
>(
	multiClosure: MultiClosure<Input>,
	closures: Closures
)
where Closures.Iterator.Element == EquatableClosure<Input>
{
   closures.forEach{multiClosure += $0}
}

/// Remove `closure` from the set of closures that runs
/// when `multiClosure` does
public func -= <Input>(
   multiClosure: MultiClosure<Input>,
   closure: EquatableClosure<Input>
) {
	multiClosure.closures -= closure.unownedSelf
	closure.multiClosures -= multiClosure.unownedSelf
}
