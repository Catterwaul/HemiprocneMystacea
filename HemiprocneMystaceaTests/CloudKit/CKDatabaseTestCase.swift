import CloudKit
import HM
import XCTest

final class CKDatabaseTestCase: XCTestCase {
	func test_request() {
		struct Record {}
		
		CKContainer.default().publicCloudDatabase.request(
			recordType: Record.self
		){get_records in}
	}
}
