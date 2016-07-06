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
					try coordinator.addPersistentStore(
						ofType: NSSQLiteStoreType,
						configurationName: nil,
						at: try! FileManager.default.urlsForDirectory(
							.documentDirectory,
							inDomains: .userDomainMask
						).last!.appendingPathComponent("\(newValue).sqlite"),
						options: [
							NSMigratePersistentStoresAutomaticallyOption: true,
							NSInferMappingModelAutomaticallyOption: true
						]
					)
				} catch {
					fatalError()
				}
				return coordinator
			}()
		}
	}
	
	///- Precondition: managedObjectModelName has been assigned
	@nonobjc private(set) static var forManagedObjectModel: NSPersistentStoreCoordinator!
}

//MARK: private 
private extension NSPersistentStoreCoordinator {
	convenience init(managedObjectModelName: String) {
		self.init(
			managedObjectModel: NSManagedObjectModel(
				contentsOf: Bundle.main.urlForResource(
					managedObjectModelName,
					withExtension: "momd"
				)!
			)!
		)
	}
}
