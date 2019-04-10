public extension SIMD2 {
  init(_ scalars: (Scalar, Scalar) ) {
    self.init(scalars.0, scalars.1)
  }
}

public extension Collection where Element == SIMD2<Double> {
  var definiteIntegral: Double? {
    guard !isEmpty
    else { return nil }

    let definiteIntegral = consecutivePairs.reduce(0.0) { definiteIntegral, points in
      let delta = points.1 - points.0
      return
        definiteIntegral
        + delta.x * points.0.y
        + delta.x * delta.y / 2
    }

    return definiteIntegral
  }
}

public extension Collection where Element == (Double, Double) {
  var definiteIntegral: Double? {
    return map( SIMD2<Double>.init(_:) ).definiteIntegral
  }
}
