import QuartzCore

public extension CALayer {	
  enum KeyPath { }

  /// - Returns: all sublayers of type `Layer`
  func getSublayers<Layer: CALayer>() -> [Layer] {
    return
      sublayers?.compactMap { $0 as? Layer }
      ?? []
  }

  /// - Returns: the first sublayer of type `Layer`
  func getSublayer<Layer: CALayer>() -> Layer? {
    return getSublayers().first
  }
}

public extension CALayer.KeyPath {
  static let rotation = transform[.rotation]
  static let scale = transform[.scale]
  static let translation = transform[.translation]
  
  private static var transform: NamedGetOnlySubscript<CATransform3D.KeyPath, String> {
    return NamedGetOnlySubscript {
      keyPath in "transform.\(keyPath.rawValue)"
    }
  }
}
