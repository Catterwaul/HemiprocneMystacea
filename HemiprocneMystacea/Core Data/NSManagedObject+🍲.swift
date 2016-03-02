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
   init(_ _0: Self🍲) {
      self.init(
         entity: NSEntityDescription.entityForName(String(Self),
            inManagedObjectContext: NSManagedObjectContext.forMainQueue
         )!,
         insertIntoManagedObjectContext: NSManagedObjectContext.forMainQueue
      )
      Self_init(_0)
   }

   ///- Returns: if an instance exists already, that;
   ///  otherwise, a new instance.
   static func instance(matching _0: Self🍲) -> Self {
      return Self.inContext.matching(_0) ?? Self(_0)
	}
}

public extension SequenceType where
   Generator.Element: NSManagedObject,
   Generator.Element: 🍲
{
   ///- Returns: first match (according to `🍲.matches`)
   func matching(_0: Generator.Element.Self🍲) -> Generator.Element? {
      return self.first{$0.matches(_0)}
   }
}