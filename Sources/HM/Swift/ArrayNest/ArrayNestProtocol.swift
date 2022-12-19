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

public extension ArrayNestProtocol {
  mutating func setElement(
    _ transform: (inout Element) throws -> Void
  ) throws {
    var element = try element
    try transform(&element)
    self = .element(element)
  }

  mutating func setElement(
    _ transform: (Element) throws -> Element
  ) throws {
    try setElement { $0 = try transform($0) }
  }

  mutating func setArray(
    _ transform: (inout [ArrayElement]) throws -> Void
  ) throws {
    var array = try array
    try transform(&array)
    self = .array(array)
  }

  mutating func setArray(
    _ transform: ([ArrayElement]) throws -> [ArrayElement]
  ) throws {
    try setArray { $0 = try transform($0) }
  }
}


// MARK: - value type
public extension ArrayNestProtocol where ArrayElement == Self {
  static func array(_ elements: [Element]) -> Self {
    array(elements.map(element))
  }

  init(_ referenceArrayNest: ReferenceArrayNest<Element>) {
    switch referenceArrayNest {
    case .element(let element):
      self = .element(element)
    case .array(let array):
      self = .array(
        array.map { .init($0.wrappedValue) }
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
