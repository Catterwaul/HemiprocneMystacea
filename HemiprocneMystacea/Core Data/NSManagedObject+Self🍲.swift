import CoreData

public extension Self🍲 where Self: NSManagedObject {
   static var inContext🔍: [Self] {
      let fetchRequest = NSFetchRequest(entityName: String(Self))
      fetchRequest.entity = NSEntityDescription.entityForName(String(Self),
         inManagedObjectContext: NSManagedObjectContext.forMainQueue
      )!
      return
         (try? NSManagedObjectContext.forMainQueue.executeFetchRequest(fetchRequest))
            as? [Self]
         ?? []
   }
   
   init(_ self🍲: Self🍲) {
      self.init(
         entity: NSEntityDescription.entityForName(String(Self),
            inManagedObjectContext: NSManagedObjectContext.forMainQueue
         )!,
         insertIntoManagedObjectContext: NSManagedObjectContext.forMainQueue
      )
      Self_init(self🍲)
   }

   ///- Returns: if an instance exists already, that;
   ///  otherwise, a new instance.
   static func instance(matching self🍲: Self🍲) -> Self {
      return Self.inContext🔍.matching(self🍲) ?? Self(self🍲)
	}
}

public extension SequenceType where
   Generator.Element: NSManagedObject,
   Generator.Element: Self🍲
{
   ///- Returns: first match (according to `CoreDataEntityType.matches`)
   func matching(self🍲: Generator.Element.Self🍲) -> Generator.Element? {
      return first🔎{$0.matches(self🍲)}
   }
}