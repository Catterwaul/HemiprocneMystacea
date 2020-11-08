import Foundation

public protocol ExpressibleBy2Tuple {
  associatedtype Element0
  associatedtype Element1

  init(_: (Element0, Element1))
}

public protocol ExpressibleByKeyValuePair: ExpressibleBy2Tuple {
  typealias Key = Element0
  typealias Value = Element1
}

extension Array: ExpressibleByDictionaryLiteral where Element: ExpressibleByKeyValuePair {
  public init(dictionaryLiteral elements: (Element.Key, Element.Value)...) {
    self = elements.map(Element.init)
  }
}

extension URLQueryItem: ExpressibleByKeyValuePair {
  public init(_ pair: (String, String?)) {
    self.init(name: pair.0, value: pair.1)
  }
}
