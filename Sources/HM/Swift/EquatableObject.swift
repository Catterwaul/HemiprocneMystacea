public protocol EquatableObject: AnyObject, Equatable { }

public extension EquatableObject {
  static func == (class0: Self, class1: Self) -> Bool { class0 === class1 }
}
