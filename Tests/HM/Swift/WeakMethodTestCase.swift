import HM
import XCTest

final class WeakMethodTestCase: XCTestCase {
  func test_noParameters() throws {
    var reference: Reference? = Reference()
    
    let assign1234 = WeakMethod(reference: reference) {
      reference in { reference.property = 1234 }
    }
    
    try assign1234()
    XCTAssertEqual(reference?.property, 1234)
    
    reference = nil
    XCTAssertThrowsError( try assign1234() ) {
      XCTAssert($0 is WeakMethod<Reference, (), Void>.ReferenceDeallocatedError )
    }
  }
  
  func test_1Parameter() throws {
    var reference: Reference? = Reference()
    
    let assign = WeakMethod(reference: reference) {
      reference in { reference.property = $0 }
    }
    
    try assign(1234)
    XCTAssertEqual(reference?.property, 1234)
    
    reference = nil
    XCTAssertThrowsError( try assign(1234) ) {
      XCTAssert($0 is WeakMethod<Reference, Int, Void>.ReferenceDeallocatedError )
    }
  }
}

private final class Reference {
  var property = 1
}
