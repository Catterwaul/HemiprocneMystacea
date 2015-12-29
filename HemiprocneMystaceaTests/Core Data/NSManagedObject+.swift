import CoreData

extension NSManagedObject {
   func save() {
      managedObjectContext!.saveSelfAndParent()
   }

   func delete() {
      managedObjectContext!.deleteObject(self)
      save()
   }
}