import CoreData

public extension InitParameters where Self: NSManagedObject {
	///- Returns: the entities of this type that are in the main Managed Object Context
	static var inContext: [Self] {
		let fetchRequest = Self.fetchRequest()
		fetchRequest.entity = NSEntityDescription.entity(
			forEntityName: String(Self),
			in: NSManagedObjectContext.forMainQueue
		)!
		return (try? NSManagedObjectContext.forMainQueue.fetch(fetchRequest)) as? [Self]
			?? []
	}
	
	/// Calls `Self_init` after being initialized into `NSManagedObjectContext.forMainQueue`.
	init(_ arguments: InitParameters) {
		self.init(
			entity: NSEntityDescription.entity(forEntityName: String(Self),
			                                   in: NSManagedObjectContext.forMainQueue
				)!,
			insertInto: NSManagedObjectContext.forMainQueue
		)
		InitParameters_init(arguments)
	}
	
	///- Returns: if an instance exists already, that;
	///  otherwise, a new instance.
	static func instance(matching arguments: InitParameters) -> Self {
		return Self.inContext.matching(arguments) ?? Self(arguments)
	}
}

public extension Sequence where
	Iterator.Element: NSManagedObject,
	Iterator.Element: InitParameters
{
	///- Returns: first match (according to `InitParameters.matches`)
	func matching(_ potentialMatch: Iterator.Element.InitParameters) -> Iterator.Element? {
		return self.first{$0.matches(potentialMatch)}
	}
}
