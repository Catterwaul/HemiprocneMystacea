#if !os(macOS)
import UIKit

public extension UIColor {
  struct HSBA {
    public var hue: CGFloat
    public var saturation: CGFloat
    public var brightness: CGFloat
    public var alpha: CGFloat
  }
  
  struct RGBA {
    public var red: CGFloat
    public var green: CGFloat
    public var blue: CGFloat
    public var alpha: CGFloat
  }
  
  convenience init(_ hsba: HSBA) {
    self.init(
      hue: hsba.hue,
      saturation: hsba.saturation,
      brightness: hsba.brightness,
      alpha: hsba.alpha
    )
  }
  
  convenience init(_ rgba: RGBA) {
    self.init(
      red: rgba.red,
      green: rgba.green,
      blue: rgba.blue,
      alpha: rgba.alpha
    )
  }
}

public extension UIColor.RGBA {
  init(_ color: UIColor) throws {
    self = try makeComponents(
      init: Self.init,
      assignComponents: color.getRed
    )
  }
}

public extension UIColor.HSBA {
  init(_ color: UIColor) throws {
    self = try makeComponents(
      init: Self.init,
      assignComponents: color.getHue
    )
  }
}

private func makeComponents<Components>(
  init: ((CGFloat, CGFloat, CGFloat, CGFloat)) -> Components,
  assignComponents: (
    UnsafeMutablePointer<CGFloat>?,
    UnsafeMutablePointer<CGFloat>?,
    UnsafeMutablePointer<CGFloat>?,
    UnsafeMutablePointer<CGFloat>?
  ) -> Bool
) throws -> Components {
  var components = (
    CGFloat(), CGFloat(), CGFloat(), CGFloat()
  )
  
  guard assignComponents(
    &components.0,
    &components.1,
    &components.2,
    &components.3
  ) else {
    throw Error()
  }
  
  return `init`(components)
}

private struct Error: Swift.Error { }
#endif
