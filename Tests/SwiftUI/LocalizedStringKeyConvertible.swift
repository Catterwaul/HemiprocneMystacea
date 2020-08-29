import SwiftUI
import SwiftUI_HM

private struct View: SwiftUI.View {
  var body: Text {
    Text(Enum.case)
  }
}

private struct ContentView_Previews: PreviewProvider {
  static var previews: View { View() }
}

private enum Enum {
  case `case`
}

extension Enum: CustomStringConvertible {
  var description: String { "💼" }
}

extension Enum: LocalizedStringKeyConvertible { }
