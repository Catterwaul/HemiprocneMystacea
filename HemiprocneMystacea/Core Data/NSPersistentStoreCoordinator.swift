import CoreData

extension NSPersistentStoreCoordinator {
   /// Set this upon app launch. Creates `forManagedObjectModel`
   public static var managedObjectModelName: String! {
      get {setOnlyPropertyGetterError()}
      set {
         forManagedObjectModel = {
            let coordinator = NSPersistentStoreCoordinator(
               managedObjectModelName: newValue
            )
            do {
               try coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                  configuration: nil,
                  URL: NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,
                     inDomains: .UserDomainMask
                  ).last!.URLByAppendingPathComponent("\(newValue).sqlite"),
                  options: [
                     NSMigratePersistentStoresAutomaticallyOption: true,
                     NSInferMappingModelAutomaticallyOption: true
                  ]
               )
            } catch {fatalError()}
            return coordinator
         }()
      }
   }
   
   ///- Precondition: managedObjectModelName has been assigned
   @nonobjc private(set) static var forManagedObjectModel: NSPersistentStoreCoordinator!

   private convenience init(managedObjectModelName: String) {
      self.init(
         managedObjectModel: NSManagedObjectModel(
            contentsOfURL: NSBundle.mainBundle().URLForResource(managedObjectModelName,
               withExtension: "momd"
            )!
         )!
      )
   }
}