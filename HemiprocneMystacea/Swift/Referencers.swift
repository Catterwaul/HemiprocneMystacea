/// Use this until Swift has unowned-referencing collections.
public final class UnownedReferencer<Reference: AnyObject>: HashableClass {
	public init(_ reference: Reference) {self.reference = reference}
   public unowned let reference: Reference
}

/// Use this until Swift has weak-referencing collections.
public final class WeakReferencer<Reference: AnyObject>: HashableClass {
   public init(_ reference: Reference) {self.reference = reference}
	public weak var reference: Reference?
}

func -= <Reference: Equatable>
(inout set: Set<UnownedReferencer<Reference>>, reference: Reference) {
	guard let referencer = set.first🔎({$0.reference == reference}) else {return}
	set -= referencer
}

func -= <Reference: Equatable>
(inout set: Set<WeakReferencer<Reference>>, reference: Reference) {
	guard let referencer = set.first🔎({$0.reference == reference}) else {return}
	set -= referencer
}