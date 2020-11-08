import HM
import XCTest

final class WeakMethodTestCase: XCTestCase {
  func test_method_noParameters() throws {
    var reference: Reference? = Reference()

    let assign1234 = WeakMethod(reference: reference, method: Reference.assign1234)

    try assign1234()
    XCTAssertEqual(reference?.property, 1234)

    reference = nil
    XCTAssertThrowsError(try assign1234()) {
      XCTAssert($0 is WeakMethod<Reference, (), Void>.ReferenceDeallocatedError)
    }
  }

  func test_method_2Parameters() throws {
    var reference: Reference? = Reference()

    let assignSum = WeakMethod(reference: reference, method: Reference.assignSum)

    XCTAssertEqual(try assignSum(2, 3), 5)
    XCTAssertEqual(reference?.property, 5)

    reference = nil
    XCTAssertThrowsError(try assignSum(2, 3)) {
      XCTAssert($0 is WeakMethod<Reference, (Int, Int), Int>.ReferenceDeallocatedError)
    }
  }

  func test_closure_noParameters() throws {
    var reference: Reference? = Reference()
    
    let assign1234 = WeakMethod(reference: reference) {
      reference in { reference.property = 1234 }
    }
    
    try assign1234()
    XCTAssertEqual(reference?.property, 1234)
    
    reference = nil
    XCTAssertThrowsError(try assign1234()) {
      XCTAssert($0 is WeakMethod<Reference, (), Void>.ReferenceDeallocatedError)
    }
  }
  
  func test_closure_1Parameter() throws {
    var reference: Reference? = Reference()
    
    let assign = WeakMethod(reference: reference) {
      reference in { reference.property = $0 }
    }
    
    try assign(1234)
    XCTAssertEqual(reference?.property, 1234)
    
    reference = nil
    XCTAssertThrowsError(try assign(1234)) {
      XCTAssert($0 is WeakMethod<Reference, Int, Void>.ReferenceDeallocatedError)
    }
  }
}

private final class Reference {
  var property = 1

  func assign1234() {
    property = 1234
  }

  func assignSum(int0: Int, int1: Int) -> Int {
    property = int0 + int1
    return property
  }
}
