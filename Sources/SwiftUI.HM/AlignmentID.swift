import SwiftUI

public protocol SingleAxisAlignmentID: AlignmentID {
  associatedtype Alignment
}

public extension View {
  func alignmentGuide<ID: SingleAxisAlignmentID>(_ idType: ID.Type) -> some View
  where ID.Alignment == HorizontalAlignment {
    alignmentGuide(
      HorizontalAlignment(idType),
      computeValue: idType.defaultValue
    )
  }

  func alignmentGuide<ID: SingleAxisAlignmentID>(_ idType: ID.Type) -> some View
  where ID.Alignment == VerticalAlignment {
    alignmentGuide(
      VerticalAlignment(idType),
      computeValue: idType.defaultValue
    )
  }
}
