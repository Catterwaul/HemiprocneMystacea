import HM
import XCTest

final class CastErrorTestCase: XCTestCase {
  func test_Self() {
    XCTAssertNoThrow(
      try cast(0, to: Int.self)
    )
    XCTAssertThrowsError(
      try failCast(of: 0, to: Int.self)
    )

    XCTAssertNoThrow(
      try failCast(of: 0, to: Class.self)
    )
    XCTAssertThrowsError(
      try cast(0, to: Class.self)
    )

    XCTAssertThrowsError(
      try failCast(of: Class(), to: Class.self)
    )
    XCTAssertNoThrow( try failCast(of: Class(), to: Double.self) )
  }

  func test_protocol() throws {
    try XCTSkip.uponFailure(
      of: try cast(Class(), to: Protocol.self)
    )

    XCTAssertThrowsError(
      try failCast(of: Class(), to: Protocol.self)
    )
  }

  func test_AnyObject() throws {
    XCTAssertThrowsError(
      try cast(0, to: AnyObject.self)
    )
    XCTAssertNoThrow(
      try failCast(of: true, to: AnyObject.self)
    )

    try XCTSkip.uponFailure(
      of: try failCast(of: Class(), to: AnyObject.self)
    )
    XCTAssertNoThrow(
      try failCast(of: Class() as Protocol, to: AnyObject.self)
    )
    XCTAssertThrowsError(
      try cast(Class() as Protocol, to: AnyObject.self)
    )
  }

  func test_inheritance() {
    XCTAssertNoThrow(
      try failCast(of: SuperClass(), to: Class.self)
    )

    XCTAssertNoThrow(
      try cast(Class(), to: SuperClass.self)
    )
    XCTAssertThrowsError(
      try failCast(of: Class(), to: SuperClass.self)
    )
  }
}

private protocol Protocol { }
private class SuperClass { }
private final class Class: SuperClass, Protocol { }

private func cast<Instance, DesiredCast>(
  _ instance: Instance, to desiredCastType: DesiredCast.Type
) throws {
  if let error = CastError(instance, desired: desiredCastType)
  { throw error }
}

private func failCast<Instance, UndesiredCast>(
  of instance: Instance, to undesiredCastType: UndesiredCast.Type
) throws {
  if let error = CastError(instance, undesired: undesiredCastType)
  { throw error }
}
