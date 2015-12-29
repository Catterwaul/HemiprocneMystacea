import CoreData

extension NSManagedObject {
   func delete() {
      managedObjectContext!.deleteObject(self)
      save()
   }
   
   func save() {
      managedObjectContext!.saveSelfAndParent()
   }
}