import CoreData

public extension NSManagedObjectContext {
   /// Its `parentContext` uses a private queue and saves to "disk"
   @nonobjc private(set) static var forMainQueue = NSManagedObjectContext(
      concurrencyType: .MainQueueConcurrencyType,
      parentContext: NSManagedObjectContext(
         concurrencyType: .PrivateQueueConcurrencyType,
         persistentStoreCoordinator: NSPersistentStoreCoordinator.forManagedObjectModel
      )
   )
   
   /// Intended for contexts on the main queue
   /// with their parent context on a background queue
   ///- Precondition: parentContext is not nil
   func saveSelfAndParent() {
      performBlockAndWait{
         do {try self.save()}
         catch let error as NSError {fatalError(error.description)}
      }
      guard let parentContext = parentContext else {fatalError()}
      parentContext.performBlock{
         do {try parentContext.save()}
         catch let error as NSError {fatalError(error.description)}
      }
   }
}
   
private extension NSManagedObjectContext {
   convenience init(
      concurrencyType: NSManagedObjectContextConcurrencyType,
      persistentStoreCoordinator: NSPersistentStoreCoordinator
   ) {
      self.init(concurrencyType: concurrencyType)
      self.persistentStoreCoordinator = persistentStoreCoordinator
   }
   
   convenience init(
      concurrencyType: NSManagedObjectContextConcurrencyType,
      parentContext: NSManagedObjectContext
   ) {
      self.init(concurrencyType: concurrencyType)
      self.parentContext = parentContext
   }
}