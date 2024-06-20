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
public extension GetMutatingSet {
  static func ?? (value: Self, default: Self) -> Self {
    do {
      _ = try value.wrappedValue()
      return value
    } catch {
      return `default`
    }
  }
}
