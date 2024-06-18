import Thrappture

/// - Note: Should be in an extension of `ThrowingPropertyWrapper`,
///   but that will result in incorrect overloading.
public extension Result {
  static func ?? (value: Self, default: Self) -> Self {
    do {
      _ = try value.wrappedValue()
      return value
    } catch {
      return `default`
    }
  }
}

/// - Note: Should be in an extension of `ThrowingPropertyWrapper`,
///   but that will result in incorrect overloading.
public extension GetThrowsMutatingSet {
  static func ?? (value: Self, default: Self) -> Self {
    do {
      _ = try value.wrappedValue()
      return value
    } catch {
      return `default`
    }
  }
}

postfix operator …?
public extension ThrowingPropertyWrapper where Value: Sequence {
  /// `wrappedValue`, or an empty sequence if it throws.
  ///
  ///  Useful for `for` loops.
  ///
  ///   ```swift
  ///       for element in optional…? {
  ///   ```
  @available(
    swift, deprecated: 6,
    message: "`-> some Sequence<Value.Element>` causes test to fail."
  )
  static postfix func …?(_ self: Self) -> UnfoldSequence<Value.Element, Value.Iterator?> {
    sequence(state: (try? self.wrappedValue())?.makeIterator()) { $0?.next() }
  }
}
