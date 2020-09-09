/// A workaround for Swift not providing a way to remove closures
/// from a collection of closures.
///- Note: Designed for one-to-many events, hence no return value.
///  Returning a single value from multiple closures doesn't make sense.
public final class MultiClosure<Input>: EquatableObject {
  public init(_ closures: EquatableClosure<Input>...) {
    self += closures
  }

  public init<Closures: Sequence>(_ closures: Closures)
  where Closures.Element == EquatableClosure<Input> {
    self += closures
  }

  var closures: Set<
    UnownedReferencer< EquatableClosure<Input> >
  > = []

//MARK: deallocation
  // We can't find self in `closures` without this.
  fileprivate lazy var unownedSelf = UnownedReferencer(self)
  
  // Even though this MultiClosure will be deallocated,
  // its corresponding WeakReferencers won't be,
  // unless we take this manual action or similar.
  deinit {
    for closure in closures {
      closure.reference.multiClosures.remove(unownedSelf)
    }
  }
}

public extension MultiClosure {
  /// Execute every closure
  func callAsFunction(_ input: Input) {
    for closure in closures {
      closure.reference(input)
    }
  }
}

public extension MultiClosure where Input == () {
  /// Execute every closure
  func callAsFunction() {
    self( () )
  }
}

/// A wrapper around a closure, for use with MultiClosures
public final class EquatableClosure<Input>: EquatableObject {
  public init(_ closure: @escaping (Input) -> Void) {
    self.closure = closure
  }

  /// Execute the closure
  func callAsFunction(_ input: Input) {
    closure(input)
  }

  private let closure: (Input) -> Void

//MARK: deallocation
  var multiClosures: Set<
    UnownedReferencer< MultiClosure<Input> >
  > = []

  // We can't find self in `multiClosures` without this.
  fileprivate lazy var unownedSelf = UnownedReferencer(self)
  
  deinit {
    for multiClosure in multiClosures {
      multiClosure.reference.closures.remove(unownedSelf)
    }
  }
}

/// Add `closure` to the set of closures that runs
/// when `multiClosure` does
public func += <Input>(
  multiClosure: MultiClosure<Input>,
  closure: EquatableClosure<Input>
) {
  multiClosure.closures.formUnion([closure.unownedSelf])
  closure.multiClosures.formUnion([multiClosure.unownedSelf])
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
where Closures.Element == EquatableClosure<Input> {
  for closure in closures {
    multiClosure += closure
  }
}

/// Remove `closure` from the set of closures that runs
/// when `multiClosure` does
public func -= <Input>(
  multiClosure: MultiClosure<Input>,
  closure: EquatableClosure<Input>
) {
  multiClosure.closures.remove(closure.unownedSelf)
  closure.multiClosures.remove(multiClosure.unownedSelf)
}
