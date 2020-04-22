import HM
import XCTest

final class CastErrorTestCase: XCTestCase {
  func test_Self() {
    XCTAssertNoThrow(
      try cast(0, to: Int.self)
    )
    XCTAssertThrowsError(
      try failCast(of: 0, to: Int.self)
    ) {
      XCTAssert($0 is CastError.Undesired<Int, Int>)
    }

    XCTAssertNoThrow(
      try failCast(of: 0, to: Class.self)
    )
    XCTAssertThrowsError(
      try cast(0, to: Class.self)
    ) {
      XCTAssert($0 is CastError.Desired<Int, Class>)
    }

    XCTAssertThrowsError(
      try failCast(of: Class(), to: Class.self)
    ) {
      XCTAssert($0 is CastError.Undesired<Class, Class>)
    }

    XCTAssertNoThrow( try failCast(of: Class(), to: Double.self) )
  }

  func test_AnyObject() {
    XCTAssertNoThrow(
      try cast(0, to: AnyObject.self)
    )

    XCTAssertNoThrow(
      try failCast(of: true, to: AnyObject.self)
    )

    XCTAssertThrowsError(
      try failCast(of: Class(), to: AnyObject.self)
    ) {
      XCTAssert($0 is CastError.Undesired<Class, AnyObject>)
    }

    XCTAssertNoThrow(
      try failCast(of: Class() as Protocol, to: AnyObject.self)
    )

    XCTAssertNoThrow(
      try cast(Class() as Protocol, to: AnyObject.self)
    )
  }
}

private protocol Protocol { }
private final class Class: Protocol { }

private func cast<Instance, DesiredCast>(
  _ instance: Instance, to desiredCastType: DesiredCast.Type
) throws {
  if let error = CastError.Desired(instance, desiredCastType)
  { throw error }
}

private func failCast<Instance, UndesiredCast>(
  of instance: Instance, to undesiredCastType: UndesiredCast.Type
) throws {
  if let error = CastError.Undesired(instance, undesiredCastType)
  { throw error }
}
