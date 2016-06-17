import CoreData

public extension NSManagedObject {
   func delete() {
      managedObjectContext!.delete(self)
   }
}

public extension InitializableWithParameters where Self: NSManagedObject {
	///- Returns: the entities of this type that are in the main Managed Object Context
	static var inContext: [Self] {
		let fetchRequest = Self.fetchRequest()
		fetchRequest.entity = NSEntityDescription.entity(
			forEntityName: String(Self),
			in: NSManagedObjectContext.forMainQueue
		)!
		return (
			try? NSManagedObjectContext.forMainQueue.fetch(fetchRequest)
		) as? [Self]
			?? []
	}
	
	/// Calls `InitializableWithParameters_init` after being initialized into `NSManagedObjectContext.forMainQueue`.
	init(_ parameters: Parameters) {
		self.init(
			entity: NSEntityDescription.entity(
				forEntityName: String(Self),
				in: NSManagedObjectContext.forMainQueue
			)!,
			insertInto: NSManagedObjectContext.forMainQueue
		)
		InitializableWithParameters_init(parameters)
	}
	
	///- Returns: if an instance exists already, that;
	///  otherwise, a new instance.
	static func instance(matching parameters: Parameters) -> Self {
		return Self.inContext.matching(parameters) ?? Self(parameters)
	}
}

public extension Sequence where
	Iterator.Element: NSManagedObject,
	Iterator.Element: InitializableWithParameters
{
	///- Returns: first match (according to `InitParameters.matches`)
	func matching(_ potentialMatch: Iterator.Element.Parameters) -> Iterator.Element? {
		return self.first{$0.matches(potentialMatch)}
	}
}
