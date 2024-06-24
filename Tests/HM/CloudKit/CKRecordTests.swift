import CloudKit
import HM
import Testing

struct CKRecordTests {
  struct Pumpkin {
    let eyesCount: Int?
    let halloween: Date?
    let vine: String?
    let weight: Measurement<UnitMass>?
    let nonCloudKitProperty = "⛈"
  }

  @Test func RawRepresentableWithCKRecordValue() throws {
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
    #expect(
      try CakeBox.Cake(
        record: CKRecord(cakeBox),
        key: CakeBox.CloudKitRecordKey.cake
      )
      ==
      cakeBox.cake
    )
  }
  
  @Test func initializeCKRecord() {
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
      unSmashingPumpkin = try! Pumpkin(record: CKRecord(mrPumpkin))

    #expect(unSmashingPumpkin.eyesCount == 2)
    #expect(unSmashingPumpkin.halloween == spookyOldHalloween)
    #expect(unSmashingPumpkin.vine == "🐛")
    #expect(unSmashingPumpkin.weight == mrPumpkin.weight)
  }
  
  @Test func IntEnum() throws {
    enum IntEnum: Int, CloudKitEnumeration {
      case zero
      case one
    }

    let record = CKRecord(IntEnum.one)
    #expect(record["rawValue"] == 1)
    #expect(try IntEnum(record: record) == .one)

    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = 0.ckRecordValue
    #expect(try IntEnum(record: record) == .zero)

    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = (-1).ckRecordValue
    #expect(throws: IntEnum?.Nil.self) { try IntEnum(record: record) }
  }
  
  @Test func StringEnum() throws {
    enum StringEnum: String, CloudKitEnumeration {
      case a
      case eh = "🇨🇦"
    }

    let record = CKRecord(StringEnum.eh)
    #expect(record["rawValue"] == "🇨🇦")
    #expect(try StringEnum(record: record) == .eh)

    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = "a".ckRecordValue
    #expect(try StringEnum(record: record) == .a)

    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = "eh".ckRecordValue
    #expect(throws: StringEnum?.Nil.self) { try StringEnum(record: record) }

    record[CloudKitEnumerationRecordKey.rawValue.rawValue] = nil
    #expect(throws: CKRecord.Value?.Nil.self) { try StringEnum(record: record) }
  }
}

extension CKRecordTests.Pumpkin: ConvertibleToCloudKitRecord {
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

extension CKRecordTests.Pumpkin {
  init(record: CKRecord) throws {
    let weightValue: Double = try cast(record[CloudKitRecordKey.weight])
    self.init(
      eyesCount: try cast(record[CloudKitRecordKey.eyesCount]),
      halloween: try cast(record[CloudKitRecordKey.halloween]),
      vine: try cast(record[CloudKitRecordKey.vine]),
      weight: Measurement(
        value: weightValue,
        unit: .kilograms
      )
    )
  }
}
