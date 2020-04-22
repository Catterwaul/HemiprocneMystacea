import HM
import XCTest

final class UndesiredCastTestCase: XCTestCase {
  func test_Self() {
    XCTAssertThrowsError(
      try failCast(of: 0, to: Int.self)
    ) {
      XCTAssert($0 is UndesiredCastError<Int, Int>)
    }

    XCTAssertThrowsError(
      try failCast(of: Class(), to: Class.self)
    ) {
      XCTAssert($0 is UndesiredCastError<Class, Class>)
    }

    XCTAssertNoThrow( try failCast(of: 0, to: Class.self) )
    XCTAssertNoThrow( try failCast(of: Class(), to: Double.self) )
  }

  func test_AnyObject() {
    XCTAssertNoThrow(
      try failCast(of: true, to: AnyObject.self)
    )

    XCTAssertThrowsError(
      try failCast(of: Class(), to: AnyObject.self)
    ) {
      XCTAssert($0 is UndesiredCastError<Class, AnyObject>)
    }

    XCTAssertNoThrow(
      try failCast(of: Class() as Protocol, to: AnyObject.self)
    )
  }
}

private protocol Protocol { }
private final class Class: Protocol { }

private func failCast<Instance, UndesiredCast>(
  of instance: Instance, to undesiredCastType: UndesiredCast.Type
) throws {
  if let error = UndesiredCastError(instance, undesiredCastType)
  { throw error }
}
