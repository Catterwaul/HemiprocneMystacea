infix operator ==== : ComparisonPrecedence

/// Like `===`, but requiring actual matching operands.
public func ==== <Object: AnyObject>(object0: Object, object1: Object) -> Bool {
  ObjectIdentifier(object0) == .init(object1)
}

infix operator !=== : ComparisonPrecedence

/// Like `!==`, but requiring actual matching operands.
public func !=== <Object: AnyObject>(object0: Object, object1: Object) -> Bool {
  !(object0 === object1)
}
