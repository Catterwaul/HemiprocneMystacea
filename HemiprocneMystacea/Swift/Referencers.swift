final class UnownedReferencer<Reference: AnyObject>: HashableClass {
	unowned let reference: Reference
	init(_ reference: Reference) {self.reference = reference}
}

final class WeakReferencer<Reference: AnyObject>: HashableClass {
	weak var reference: Reference?
	init(_ reference: Reference) {self.reference = reference}
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