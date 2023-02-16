import Combine
import SwiftUI
import XCTest

final class ObservableObjectCollection_DynamicPropertyTestCase: XCTestCase {
  @MainActor func test() {
    struct View {
      final class Object: ObservableObject {
        @Published var property = "🤵🏻‍♀️"
        @Published.Object.Collection var array: [Object] = []
      }

      @ObservedObject.Collection var observed: [Object] = []
      @StateObject.Collection var state: [Object] = [.init(), .init()]
    }

    let view = View()
    view.observed = [.init(), .init()]

    var value: String? = nil
    var cancellable = view.observed[0].objectWillChange.sink {
      value = view.observed[0].property
    }
    _ = cancellable
    view.observed[0].property = "🤵🏽‍♂️"
    XCTAssertEqual(value, "🤵🏻‍♀️")

    view.state[0].array = [.init()]
    cancellable = view.state[0].objectWillChange.sink {
      value = view.observed[0].property
      XCTAssertEqual(value, "🤵🏽‍♂️")
    }
    view.state[0].array[0].property = "🤵"
  }
}
