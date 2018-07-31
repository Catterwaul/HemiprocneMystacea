public protocol EquatableClass: AnyObject, Equatable { }

public extension EquatableClass {
  static func == (class0: Self, class1: Self) -> Bool {
    return class0 === class1
  }
}
