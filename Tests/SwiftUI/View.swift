import SwiftUI
import SwiftUI_HM

extension HorizontalAlignment {
  enum CustomCenter: SingleAxisAlignmentID {
    typealias Alignment = HorizontalAlignment

    static func defaultValue(in dimensions: ViewDimensions) -> CGFloat {
      dimensions[Alignment.center]
    }
  }

  static let customCenter = Self(CustomCenter.self)
}

private struct View: SwiftUI.View {
  var body: some SwiftUI.View {
    VStack(alignment: .customCenter) {
      Text("")
        .alignmentGuide(HorizontalAlignment.CustomCenter.self)
    }
  }
}

private struct ContentView_Previews: PreviewProvider {
   static var previews: View { View() }
}
