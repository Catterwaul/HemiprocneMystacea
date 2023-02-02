import Combine
import SwiftUI
import SwiftUI_HM
import XCTest

final class ObservableObjectCollection_DynamicPropertyTestCase: XCTestCase {
  @MainActor func test() {
    struct View {
      final class Object: ObservableObject { }
      @ObservedObject.Collection var observed: [Object] = []
      @StateObject.Collection var state3: [Object] = []
    }

    _ = View()
  }
}
