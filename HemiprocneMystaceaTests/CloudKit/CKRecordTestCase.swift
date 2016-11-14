import CloudKit
import HM
import XCTest

final class CKRecordTestCase: XCTestCase {
	func test_initialize_CKRecord() {
		let
		spookyOldHalloween = Date.distantPast,
		mrPumpkin = Pumpkin(
			eyesCount: 2,
			halloween: spookyOldHalloween,
			vine: "🐛"
		),
		unSmashingPumpkin = Pumpkin(
			record: CKRecord(mrPumpkin)
		)

		XCTAssertEqual(unSmashingPumpkin.eyesCount, 2)
		XCTAssertEqual(unSmashingPumpkin.halloween, spookyOldHalloween)
		XCTAssertEqual(unSmashingPumpkin.vine, "🐛")
	}

	struct Pumpkin {
		let
		eyesCount: Int?,
		halloween: Date?,
		vine: String?,
		nonCloudKitProperty = "⛈"
	}
}

extension CKRecordTestCase.Pumpkin: ConvertibleToCloudKitRecord {
	enum CloudKitRecordKey: String {
		case
		eyesCount,
		halloween,
		vine
	}
}

extension CKRecordTestCase.Pumpkin {
	init(record: CKRecord) {
		self.init(
			eyesCount: record.getValue(key: CloudKitRecordKey.eyesCount),
			halloween: record.getValue(key: CloudKitRecordKey.halloween),
			vine: record.getValue(key: CloudKitRecordKey.vine)
		)
	}
}
