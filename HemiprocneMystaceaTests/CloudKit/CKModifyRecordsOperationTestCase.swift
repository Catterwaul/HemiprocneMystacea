import CloudKit
import HM
import XCTest

final class CKModifyRecordsOperationTestCase: XCTestCase {
	func test_initialize() {
		_ = CKModifyRecordsOperation{
			verifyCompletion in try! verifyCompletion()
		}
	}
}
