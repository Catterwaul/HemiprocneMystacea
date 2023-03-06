import HM
import XCTest

final class OptionSetTypeTestCase: XCTestCase {
  func test_2Flags() {
    let options: Options = [.option1, .option2]
    XCTAssertEqual(options.rawValue, 0b11)
  }
  
  func test_3Flags() {
    let options: Options = [
      .option3,
      .option4,
      .option5
    ]
    XCTAssertEqual(options.rawValue, 0b1_1100)
  }
  
  func test_4Flags() {
    let options: Options = [
      .option6,
      .option7,
      .option8,
      .option9
    ]
    XCTAssertEqual(options.rawValue, 0b1_1110_0000)
  }
  
  func test_5Flags() {
    let options: Options = [
      .option10,
      .option11,
      .option12,
      .option13,
      .option14
    ]
    XCTAssertEqual(options.rawValue, 0b11_1110_0000_0000)
  }
  
  func test_6Flags() {
    let options: Options = [
      .option15,
      .option16,
      .option17,
      .option18,
      .option19,
      .option20
    ]
    XCTAssertEqual(options.rawValue, 0b1111_1100_0000_0000_0000)
  }
  
#if !(os(macOS) || os(watchOS))
  func testInitWithCompatibleOptionSet() {
    let view = UIView()
    
    view.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
    XCTAssertEqual(
      view.autoresizingFlexibilities,
      [.bottomMargin, .topMargin, .width]
    )
    
    view.autoresizingFlexibilities = [.height, .leftMargin, .rightMargin]
    XCTAssertEqual(
      view.autoresizingMask,
      [.flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin]
    )
  }
#endif
}

private struct Options: OptionSet {
  init(rawValue: UInt) {
    self.rawValue = rawValue
  }
  
  let rawValue: UInt
  
  static let (option1, option2) = Self[]
  static let (
    option3,
    option4,
    option5
  ) = Self[startingFlagIndex: 2]
  static let (
    option6,
    option7,
    option8,
    option9
  ) = Self[startingFlagIndex: 5]
  static let (
    option10,
    option11,
    option12,
    option13,
    option14
  ) = Self[startingFlagIndex: 9]
  static let (
    option15,
    option16,
    option17,
    option18,
    option19,
    option20
  ) = Self[startingFlagIndex: 14]
}

#if !(os(macOS) || os(watchOS))
extension UIView {
  struct AutoresizingFlexibilities: OptionSet {
    let rawValue: UInt
  }
  
  var autoresizingFlexibilities: AutoresizingFlexibilities {
    get { .init(autoresizingMask) }
    set { autoresizingMask = .init(newValue) }
  }
}

extension UIView.AutoresizingFlexibilities {
  static var leftMargin: UIView.AutoresizingFlexibilities {
    .init(UIView.AutoresizingMask.flexibleLeftMargin)
  }
  
  static var width: UIView.AutoresizingFlexibilities {
    .init(UIView.AutoresizingMask.flexibleWidth)
  }
  
  static var rightMargin: UIView.AutoresizingFlexibilities {
    .init(UIView.AutoresizingMask.flexibleRightMargin)
  }
  
  static var topMargin: UIView.AutoresizingFlexibilities {
    .init(UIView.AutoresizingMask.flexibleTopMargin)
  }
  
  static var height: UIView.AutoresizingFlexibilities {
    .init(UIView.AutoresizingMask.flexibleHeight)
  }
  
  static var bottomMargin: UIView.AutoresizingFlexibilities {
    .init(UIView.AutoresizingMask.flexibleBottomMargin)
  }
}
#endif
