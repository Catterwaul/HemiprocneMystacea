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
    _ transform: (Element) throws -> Element
  ) throws {
    self = .element(try transform(element))
  }

  mutating func setArray(
    _ transform: ([ArrayElement]) throws -> [ArrayElement]
  ) throws {
    self = .array(try transform(array))
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
