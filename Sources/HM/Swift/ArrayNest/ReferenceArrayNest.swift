public enum ReferenceArrayNest<Element> {
  case element(Element)
  case array([Reference<Self>] = [])
}

extension ReferenceArrayNest: ArrayNestProtocol {
  public var element: Element {
    get throws {
      guard case .element(let element) = self else {
        throw Error.accessedArrayAsElement
      }
      return element
    }
  }

  public var array: [ArrayElement] {
    get throws {
      guard case .array(let array) = self else {
        throw Error.accessedElementAsArray
      }
      return array
    }
  }
}
