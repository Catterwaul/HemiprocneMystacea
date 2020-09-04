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

  func test_RawRepresentableWithCKRecordValue() {
    struct CakeBox: ConvertibleToCloudKitRecord, Equatable {
      enum Cake: String, RawRepresentableWithCKRecordValue {
        case 🥮, 🧁, 🍰, 🍥, 🎂
      }

      enum CloudKitRecordKey: String {
        case cake
      }

      let cake: Cake
    }

    let cakeBox = CakeBox(cake: .🥮)
    XCTAssertEqual(
      try CakeBox.Cake(
        record: CKRecord(cakeBox),
        key: CakeBox.CloudKitRecordKey.cake
      ),
      cakeBox.cake
    )
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
  
  func test_IntEnum() {
    enum IntEnum: Int, CloudKitEnumeration {
      case zero
      case one
    }

    let record = CKRecord(IntEnum.one)
    XCTAssertEqual(try record.value(for: "rawValue"), 1)
    XCTAssertEqual(try IntEnum(record: record), .one)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = 0.ckRecordValue
    XCTAssertEqual(try IntEnum(record: record), .zero)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = (-1).ckRecordValue
    XCTAssertThrowsError( try IntEnum(record: record) ) { error in
      switch error {
      case ConcreteRawRepresentable<IntEnum>.Error.invalidRawValue(let rawValue):
        XCTAssertEqual(rawValue, -1)
      default:
        XCTFail()
      }
    }
  }
  
  func test_StringEnum() {
    enum StringEnum: String, CloudKitEnumeration {
      case a
      case eh = "🇨🇦"
    }

    let record = CKRecord(StringEnum.eh)
    XCTAssertEqual(try record.value(for: "rawValue"), "🇨🇦")
    XCTAssertEqual(try StringEnum(record: record), .eh)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = "a".ckRecordValue
    XCTAssertEqual(try StringEnum(record: record), .a)
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = "eh".ckRecordValue
    XCTAssertThrowsError( try StringEnum(record: record) ) { error in
      switch error {
      case ConcreteRawRepresentable<StringEnum>.Error.invalidRawValue(let rawValue):
        XCTAssertEqual(rawValue, "eh")
      default:
        XCTFail()
      }
    }
    
    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = nil
    XCTAssertThrowsError( try StringEnum(record: record) ) {
      XCTAssert(CKRecord.AccessError.noValue ~= $0)
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
    dictionary[.weight] = weight.map(\.value.ckRecordValue)
    return dictionary
  }
}

extension CKRecordTestCase.Pumpkin {
  init(record: CKRecord) throws {
    let weightValue: Double = try record.value(for: CloudKitRecordKey.weight)
    self.init(
      eyesCount: try record.value(for: CloudKitRecordKey.eyesCount),
      halloween: try record.value(for: CloudKitRecordKey.halloween),
      vine: try record.value(for: CloudKitRecordKey.vine),
      weight: Measurement(
        value: weightValue,
        unit: .kilograms
      )
    )
  }
}
