import HM
import XCTest

final class AnyObjectTestCase: XCTestCase {
  func test_AnyObjectError() {
    func returnValue<Value>(_ value: Value) throws -> Value {
      if let error = AnyObjectError(value)
      { throw error }

      return value
    }

    XCTAssertEqual(try returnValue(0), 0)

    final class Class: EquatableClass, Protocol { }

    let classInstance = Class()
    do { _ = try returnValue(classInstance) }
    catch let error as AnyObjectError<Class> {
      XCTAssertEqual(error.object, classInstance)
    }
    catch { XCTFail() }

    XCTAssertNoThrow(
      try returnValue(classInstance as Protocol)
    )
  }
}

private protocol Protocol { }
