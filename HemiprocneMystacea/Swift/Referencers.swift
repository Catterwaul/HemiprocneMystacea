/// Use this until Swift has unowned-referencing collections.
public final class UnownedReferencer<Reference: AnyObject>: HashableClass {
  public init(_ reference: Reference) {
    self.reference = reference
  }
  
  public unowned let reference: Reference
}

/// Use this until Swift has weak-referencing collections.
public final class WeakReferencer<Reference: AnyObject>: HashableClass {
  public init(_ reference: Reference) {
    self.reference = reference
  }
  
  public weak var reference: Reference?
}

/// Remove the first `UnownedReferencer` with this `reference`
public func -= <Reference: Equatable>(
  set: inout Set< UnownedReferencer<Reference> >,
  reference: Reference
) {
  guard let referencer = ( set.first {$0.reference == reference} )
  else {return}
  
  set -= referencer
}

/// Remove the first `WeakReferencer` with this `reference`
public func -= <Reference: Equatable>(
  set: inout Set< WeakReferencer<Reference> >,
  reference: Reference
) {
  guard let referencer = ( set.first {$0.reference == reference} )
  else {return}
  
  set -= referencer
}
