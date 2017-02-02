import CloudKit
import HM
import XCTest

final class CKRecordTestCase: XCTestCase {
	func test_initializeCKRecord() {
		let
			spookyOldHalloween = Date.distantPast,
			mrPumpkin = Pumpkin(
				eyesCount: 2,
				halloween: spookyOldHalloween,
				vine: "🐛",
				weight: Measurement(
					value: 9000,
					unit: .kilograms
				)
			),
			unSmashingPumpkin = Pumpkin( record: CKRecord(mrPumpkin) )

		XCTAssertEqual(unSmashingPumpkin.eyesCount, 2)
		XCTAssertEqual(unSmashingPumpkin.halloween, spookyOldHalloween)
		XCTAssertEqual(unSmashingPumpkin.vine, "🐛")
		XCTAssertEqual(unSmashingPumpkin.weight, mrPumpkin.weight)
	}

	struct Pumpkin {
		let eyesCount: Int?
		let halloween: Date?
		let vine: String?
		let weight: Measurement<UnitMass>?
		let nonCloudKitProperty = "⛈"
	}
}

extension CKRecordTestCase.Pumpkin: ConvertibleToCloudKitRecord {
	enum CloudKitRecordKey: String {
		case eyesCount
		case halloween
		case vine
		case weight
	}
	
	var recordDictionaryOverrides: [CloudKitRecordKey: CKRecordValue] {
		var dictionary: [CloudKitRecordKey: CKRecordValue] = [:]
		dictionary[.weight] = weight.map{$0.value as NSNumber}
		return dictionary
	}
}

extension CKRecordTestCase.Pumpkin {
	init(record: CKRecord) {
		self.init(
			eyesCount: record.getValue(key: CloudKitRecordKey.eyesCount),
			halloween: record.getValue(key: CloudKitRecordKey.halloween),
			vine: record.getValue(key: CloudKitRecordKey.vine),
			weight: record.getValue(key: CloudKitRecordKey.weight).map{
				weight in Measurement(
					value: weight,
					unit: .kilograms
				)
			}
		)
	}
}
