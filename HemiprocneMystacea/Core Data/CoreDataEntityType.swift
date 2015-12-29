import CoreData

/// Designed to add functionality to classes deriving from *NSManagedObject*
public protocol CoreDataEntityType {
	typealias Self🍲
   func matches(self🍲: Self🍲) -> Bool
	func Self_init(self🍲: Self🍲)
}

// Every CoreDataEntityType will be an NSManagedObject.
extension CoreDataEntityType where Self: NSManagedObject {
   public static var inContext🔍: [Self] {
      let fetchRequest = NSFetchRequest(entityName: className)
      fetchRequest.entity = NSEntityDescription.entityForName(className,
         inManagedObjectContext: NSManagedObjectContext.forMainQueue
      )!
      return
         (try? NSManagedObjectContext.forMainQueue.executeFetchRequest(fetchRequest))
            as? [Self]
         ?? []
   }
   
   public init(_ self🍲: Self🍲) {
      self.init(
         entity: NSEntityDescription.entityForName(Self.className,
            inManagedObjectContext: NSManagedObjectContext.forMainQueue
         )!,
         insertIntoManagedObjectContext: NSManagedObjectContext.forMainQueue
      )
      Self_init(self🍲)
   }

   ///- Returns: if an instance exists already, that;
   ///  otherwise, a new instance.
   public static func instance(matching self🍲: Self🍲) -> Self {
      return Self.inContext🔍.matching(self🍲) ?? Self(self🍲)
	}
}

extension SequenceType where
   Generator.Element: CoreDataEntityType,
   Generator.Element: NSManagedObject
{
   public func matching(self🍲: Generator.Element.Self🍲) -> Generator.Element? {
      return first🔎{$0.matches(self🍲)}
   }
}