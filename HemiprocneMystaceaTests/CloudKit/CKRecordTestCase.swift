import CloudKit
import HM
import XCTest

final class CKRecordTestCase: XCTestCase {
	func test_initialize_CKRecord() {
		let
		mrPumpkin = Pumpkin(
			eyesCount: 2,
			vine: "🐛"
		),
		unSmashingPumpkin = Pumpkin(
			record: CKRecord(mrPumpkin)
		)

		XCTAssertEqual(unSmashingPumpkin.eyesCount, 2)
		XCTAssertEqual(unSmashingPumpkin.vine, "🐛")
	}

	struct Pumpkin {
		let
		eyesCount: Int,
		vine: String,
		nonCloudKitProperty = "⛈"
	}
}

extension CKRecordTestCase.Pumpkin: ConvertibleToCloudKitRecord {
	enum CloudKitRecordKey: String {
		case eyesCount, vine
	}
}

extension CKRecordTestCase.Pumpkin {
	init(record: CKRecord) {
		self.init(
			eyesCount: record.get_value(key: CloudKitRecordKey.eyesCount)!,
			vine: record.get_value(key: CloudKitRecordKey.vine)!
		)
	}
}
