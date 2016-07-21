import CloudKit

public extension CKDatabase {
	func request<Requested: InitializableWithCloudKitRecord>(
		predicate: Predicate = Predicate(value: true),
		process: Process< Throwing.Get<[Requested]> >
	){
		perform(
			CKQuery(
				recordType: String(Requested.self),
				predicate: predicate
			),
			inZoneWith: nil
		){	records, error in
			
			if let error = error {
				process{throw error}
				return
			}
			
			process{
				records!.map(Requested.init)
			}
		}
	}
}
