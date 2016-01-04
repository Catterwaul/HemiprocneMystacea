import HemiprocneMystacea
import XCTest

final class EquatableTestCase: XCTestCase {
   func testTypeWith1EquatableProperty() {
      let instances = (
         TypeWith1EquatableProperty(bool: true),
         TypeWith1EquatableProperty(bool: true)
      )
      XCTAssertEqual(instances.0, instances.1)
   }
   
   func testTypeWith2EquatableProperties() {
      let instances = (
         TypeWith2EquatableProperties(bool: true, double: 2),
         TypeWith2EquatableProperties(bool: true, double: 2)
      )
      XCTAssertEqual(instances.0, instances.1)
   }
   
   func testTypeWith5EquatableProperties() {
      let instance = TypeWith5EquatableProperties(
         bool: true,
         double: 2,
         float: 1,
         int: 800,
         string: "sdaffgqfejnjkn"
      )
      XCTAssertEqual(instance, instance)
   }
}

private struct TypeWith1EquatableProperty: Equatable {
   let bool: Bool
}
private func == (left: TypeWith1EquatableProperty, right: TypeWith1EquatableProperty)
-> Bool {
   return left == (right, {$0.bool})
}

private struct TypeWith2EquatableProperties: Equatable {
   let
      bool: Bool,
      double: Double
}
private func == (left: TypeWith2EquatableProperties, right: TypeWith2EquatableProperties)
-> Bool {
   return left == (right,
      {$0.bool},
      {$0.double}
   )
}

private struct TypeWith5EquatableProperties: Equatable {
   let
      bool: Bool,
      double: Double,
      float: Float,
      int: Int,
      string: String
}
private func == (left: TypeWith5EquatableProperties, right: TypeWith5EquatableProperties)
-> Bool {
   return left == (right,
      {$0.bool},
      {$0.double},
      {$0.float},
      {$0.int},
      {$0.string}
   )
}