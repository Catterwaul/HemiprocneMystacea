import SwiftUI
import SwiftUI_HM

private struct View: SwiftUI.View {
  @State var property: Void?

  var body: some SwiftUI.View {
    Button("Button") { property = () }
      .alert("🚨", presenting: $property) { _ in
        Button("✅") { }
      } message: { _ in
        Text("‼️")
      }
  }
}


private struct ContentView_Previews: PreviewProvider {
  static var previews: View { View() }
}
