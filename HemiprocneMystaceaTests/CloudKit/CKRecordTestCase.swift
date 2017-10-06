import CloudKit
import HM
import XCTest

final class CKRecordTestCase: XCTestCase {
  struct Pumpkin {
    let eyesCount: Int?
    let halloween: Date?
    let vine: String?
    let weight: Measurement<UnitMass>?
    let nonCloudKitProperty = "⛈"
  }
  
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
      unSmashingPumpkin = try! Pumpkin( record: CKRecord(mrPumpkin) )

    XCTAssertEqual(unSmashingPumpkin.eyesCount, 2)
    XCTAssertEqual(unSmashingPumpkin.halloween, spookyOldHalloween)
    XCTAssertEqual(unSmashingPumpkin.vine, "🐛")
    XCTAssertEqual(unSmashingPumpkin.weight, mrPumpkin.weight)
  }
  
  enum IntEnum: Int, CloudKitEnumeration {
    case zero
    case one
  }
  func testIntEnum() {
    let record = CKRecord(IntEnum.one)
    XCTAssertEqual(try record.getValue(key: "rawValue"), 1)
    XCTAssertEqual(try IntEnum(record: record), .one)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = 0.ckRecordValue
    XCTAssertEqual(try IntEnum(record: record), .zero)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = (-1).ckRecordValue
    XCTAssertThrowsError(try IntEnum(record: record)) {
      switch $0 {
      case let error as CloudKitEnumerationInitializationError<Int>:
        XCTAssertEqual(error.rawValue, -1)
        
      default: XCTFail()
      }
    }
  }
  
  enum StringEnum: String, CloudKitEnumeration {
    case a
    case eh = "🇨🇦"
  }
  func testStringEnum() {    
    let record = CKRecord(StringEnum.eh)
    XCTAssertEqual(try record.getValue(key: "rawValue"), "🇨🇦")
    XCTAssertEqual(try StringEnum(record: record), .eh)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = "a".ckRecordValue
    XCTAssertEqual(try StringEnum(record: record), .a)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = "eh".ckRecordValue
    XCTAssertThrowsError(try StringEnum(record: record)) {
      switch $0 {
      case let error as CloudKitEnumerationInitializationError<String>:
        XCTAssertEqual(error.rawValue, "eh")
      
      default: XCTFail()
      }
    }
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = nil
    XCTAssertThrowsError( try StringEnum(record: record) ) {
      switch $0 {
      case GetValueForKeyError<String>.noValue: return
      default: XCTFail()
      }
    }
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
    dictionary[.weight] = weight.flatMap {$0.value.ckRecordValue}
    return dictionary
  }
}

extension CKRecordTestCase.Pumpkin {
  init(record: CKRecord) throws {
    let weightValue: Double = try record.getValue(nonRawKey: CloudKitRecordKey.weight)
    self.init(
      eyesCount: try record.getValue(nonRawKey: CloudKitRecordKey.eyesCount),
      halloween: try record.getValue(nonRawKey: CloudKitRecordKey.halloween),
      vine: try record.getValue(nonRawKey: CloudKitRecordKey.vine),
      weight: Measurement(
        value: weightValue,
        unit: .kilograms
      )
    )
  }
}
