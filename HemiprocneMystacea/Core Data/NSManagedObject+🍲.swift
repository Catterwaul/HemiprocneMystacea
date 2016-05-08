import CoreData

public extension 🍲 where Self: NSManagedObject {
   ///- Returns: the entities of this type that are in the main Managed Object Context
   static var inContext: [Self] {
      let fetchRequest = NSFetchRequest(entityName: String(Self))
      fetchRequest.entity = NSEntityDescription.entityForName(String(Self),
         inManagedObjectContext: NSManagedObjectContext.forMainQueue
      )!
      return
         (try? NSManagedObjectContext.forMainQueue.executeFetchRequest(fetchRequest))
            as? [Self]
         ?? []
   }
   
   /// Calls `Self_init` after being initialized into `NSManagedObjectContext.forMainQueue`.
   init(_ 💰0: Self🍲) {
      self.init(
         entity: NSEntityDescription.entityForName(String(Self),
            inManagedObjectContext: NSManagedObjectContext.forMainQueue
         )!,
         insertIntoManagedObjectContext: NSManagedObjectContext.forMainQueue
      )
      Self_init(💰0)
   }

   ///- Returns: if an instance exists already, that;
   ///  otherwise, a new instance.
   static func instance(matching 💰0: Self🍲) -> Self {
      return Self.inContext.matching(💰0) ?? Self(💰0)
	}
}

public extension SequenceType where
   Generator.Element: NSManagedObject,
   Generator.Element: 🍲
{
   ///- Returns: first match (according to `🍲.matches`)
   func matching(potentialMatch: Generator.Element.Self🍲) -> Generator.Element? {
      return self.first{$0.matches(potentialMatch)}
   }
}