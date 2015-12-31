import HemiprocneMystacea
import XCTest

final class SetAlgebraTypeTestCase: XCTestCase {
   func testInsert() {
      var options: Options = [.A1, .B2]
      options += .C3
      XCTAssertEqual(options, [.A1, .B2, .C3])
   }
   
   func testRemove() {
      var options: Options = [.A1, .B2]
      options -= .C3
      options -= .A1
      XCTAssertEqual(options, [.B2])
   }

   func testIntersect() {      
      var options: Options = [.A1, .B2, .C3]
      options = options ∩ [.A1, .C3, .D4, .F6]
      XCTAssertEqual(options, [.C3, .A1])
   }
   
   func testIntersectEquals() {
      var options: Options = [.A1, .B2, .C3]
      options ∩= [.A1, .C3, .D4, .F6]
      XCTAssertEqual(options, [.C3, .A1])
   }
   
   func testUnion() {
      var options: Options = [.A1, .B2, .C3, .E5]
      options = options ∪ [.A1, .C3, .D4, .E5, .F6]
      XCTAssertEqual(options, [.A1, .B2, .C3, .D4, .E5, .F6])
   }

   func testUnionEquals() {
      var options: Options = [.A1, .B2, .C3, .E5]
      options ∪= [.A1, .C3, .D4, .E5, .F6]
      XCTAssertEqual(options, [.A1, .B2, .C3, .D4, .E5, .F6])
   }
}

private struct Options: OptionSetType {
   init(rawValue: UInt) {self.rawValue = rawValue}
   let rawValue: UInt
   
   static let (A1, B2, C3, D4, E5, F6) = Options.Flags()
}