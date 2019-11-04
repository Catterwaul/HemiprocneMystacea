public protocol EquatableClass: AnyObject, Equatable { }

public extension EquatableClass {
  static func == (class0: Self, class1: Self) -> Bool { class0 === class1 }
}
