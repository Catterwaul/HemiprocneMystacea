public protocol ArrayNestProtocol<Element, ArrayElement> {
  typealias Error = ArrayNestError

  associatedtype Element
  associatedtype ArrayElement

  static func element(_: Element) -> Self
  static func array(_: [ArrayElement]) -> Self

  var element: Element { get throws }
  var array: [ArrayElement] { get throws }
}

public enum ArrayNestError: Error {
  case accessedArrayAsElement
  case accessedElementAsArray
}

// MARK: - value type
public extension ArrayNestProtocol where ArrayElement == Self {
  static func array(_ elements: [Element]) -> Self {
    array(elements.map(element))
  }

  init<ReferenceArrayNest: ArrayNestProtocol>(
    _ referenceArrayNest: ReferenceArrayNest
  )
  where
    ReferenceArrayNest.Element == Element,
    ReferenceArrayNest.ArrayElement == Reference<ReferenceArrayNest>
  {
    do {
      self = .element(try referenceArrayNest.element)
    } catch {
      self = .array(
        try! referenceArrayNest.array.map { .init($0.wrappedValue) }
      )
    }
  }
}

// MARK: - reference type

public extension ArrayNestProtocol where ArrayElement == Reference<Self> {
  static func array(_ elements: [Element]) -> Self {
    array(elements.map(ArrayElement.element))
  }
}

public extension Reference
where Value: ArrayNestProtocol, Value.ArrayElement == Reference {
  static func element(_ element: Value.Element) -> Self {
    .init(wrappedValue: .element(element))
  }

  static func array(_ array: [Reference] = []) -> Self {
    .init(wrappedValue: .array(array))
  }

  static func array(_ elements: [Value.Element]) -> Self {
    .init(wrappedValue: .array(elements))
  }
}
