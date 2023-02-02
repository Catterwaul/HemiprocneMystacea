import Combine
import HM
import XCTest

final class ObservableObjectTestCase: XCTestCase {
  func test_forwardedObjectWillChangeCancellables() {
    final class ObservableObjectParent: HM.ObservableObjectParent {
      final class ObservableObject: Combine.ObservableObject {
        @Published var property: Void = ()
      }

      let observableObject = ObservableObject()
      private var cancellable: AnyCancellable!

      init() {
        cancellable = childrenObjectWillChanges.merged.subscribe(objectWillChange)
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
