import CoreGraphics

public extension CGRect {
  // MARK: - Initializers

  init(
    x: CGFloat, y: CGFloat,
    size: some CommonOperable<SIMD2<CGFloat.NativeType>>
  ) {
    self.init(
      origin: CGPoint(x: x, y: y),
      size: CGSize(size)
    )
  }

  // MARK: - Properties

  var center: CGPoint { .init(x: midX, y: midY) }
  var max: CGPoint { .init(x: maxX, y: maxY) }

  @available(macOS 15, iOS 18, watchOS 11, *)
  var points: Set<CGPoint> {
    [ [minX, maxY], [maxX, maxY],
      [minX, minY], [maxX, minY]
    ]
  }
}
