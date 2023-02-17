import SwiftUI_HM
import XCTest
import SwiftUI

private struct View {
  @AppStorage.Converter("🗝️") var date = .now
}
