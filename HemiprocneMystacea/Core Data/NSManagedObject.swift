import CoreData

public extension NSManagedObject {
   func delete() {
      managedObjectContext!.deleteObject(self)
   }
   
   func save() {
      managedObjectContext!.saveSelfAndParent()
   }
}