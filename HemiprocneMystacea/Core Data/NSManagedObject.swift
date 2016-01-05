import CoreData

public extension NSManagedObject {
   func delete() {
      save()
      managedObjectContext!.deleteObject(self)
      save()
   }
   
   func save() {
      managedObjectContext!.saveSelfAndParent()
   }
}