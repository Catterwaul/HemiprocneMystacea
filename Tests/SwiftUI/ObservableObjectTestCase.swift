import Combine
import SwiftUI_HM
import XCTest

final class ObservableObjectTestCase: XCTestCase {
  func test_forwardedObjectWillChangeCancellables() {
    final class ObservableObjectParent: SwiftUI_HM.ObservableObjectParent {
      final class ObservableObject: Combine.ObservableObject {
        @Published var property: Void = ()
      }

      let observableObject = ObservableObject()
      private var cancellable: AnyCancellable!

      init() {
        cancellable = childrenObjectWillChanges.forwardedThroughObjectWillChange(of: self)
      }
    }

    let object = ObservableObjectParent()
    var value: Void? = nil
    let cancellable = object.objectWillChange.sink { value = $0 }
    _ = cancellable
    object.observableObject.property = ()
    XCTAssertNotNil(value)
  }
}
