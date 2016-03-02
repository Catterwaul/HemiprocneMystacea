import CoreData

public extension NSManagedObject {
   func delete() {
      managedObjectContext!.deleteObject(self)
   }
}