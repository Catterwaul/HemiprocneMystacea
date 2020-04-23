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

  func test_protocol() {
    XCTAssertNoThrow(
      try cast(Class(), to: Protocol.self)
    )
    XCTAssertThrowsError(
      try failCast(of: Class(), to: Protocol.self)
    )
  }

  func test_AnyObject() {
    XCTAssertThrowsError(
      try cast(0, to: AnyObject.self)
    )
    XCTAssertNoThrow(
      try failCast(of: true, to: AnyObject.self)
    )

    XCTAssertThrowsError(
      try failCast(of: Class(), to: AnyObject.self)
    )
    XCTAssertNoThrow(
      try failCast(of: Class() as Protocol, to: AnyObject.self)
    )
    XCTAssertThrowsError(
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
