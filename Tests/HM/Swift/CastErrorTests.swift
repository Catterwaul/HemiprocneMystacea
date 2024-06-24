import HM
import Testing

struct CastErrorTests {
  @Test func `self`() throws {
    _ = try cast(0) as Int
    #expect(throws: CastError.self) { try cast(0) as Class }
  }

  @Test func `protocol`() throws {
    _ = try cast(Class()) as Protocol
  }

  @Test func AnyObject() throws {
    _ = try cast(0) as AnyObject
    _ = try cast(Class()) as AnyObject
    _ = try cast(Class() as Protocol) as AnyObject
  }

  @Test func inheritance() throws {
    #expect(throws: CastError.self) { try cast(SuperClass()) as Class }
    _ = try cast(Class()) as SuperClass
  }
}

private protocol Protocol { }
private class SuperClass { }
private final class Class: SuperClass, Protocol { }
