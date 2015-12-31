import HemiprocneMystacea
import XCTest

final class OptionSetTypeTestCase: XCTestCase {
   func test2Flags() {
      let options: Options = [.Option1, .Option2]
      XCTAssertEqual(options.rawValue, 0b11)
   }
   
   func test3Flags() {
      let options: Options = [.Option3, .Option4, .Option5]
      XCTAssertEqual(options.rawValue, 0b1_1100)
   }
   
   func test4Flags() {
      let options: Options = [.Option6, .Option7, .Option8, .Option9]
      XCTAssertEqual(options.rawValue, 0b1_1110_0000)
   }
}

private struct Options: OptionSetType {
   init(rawValue: UInt) {self.rawValue = rawValue}
   let rawValue: UInt
   
   static let
      (Option1, Option2) = Options.Flags(),
      (Option3, Option4, Option5) = Options.Flags(startingIndex: 3),
      (Option6, Option7, Option8, Option9) = Options.Flags(startingIndex: 6)
}