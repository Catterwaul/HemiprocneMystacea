import CoreData

public extension NSManagedObject {
   func delete() {
      managedObjectContext!.delete(self)
   }
}
