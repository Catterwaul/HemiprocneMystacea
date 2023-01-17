#if canImport(QuartzCore)
import QuartzCore

public extension CATransform3D {
  enum KeyPath: String {
		case rotation
		case scale
		case translation
	}
}
#endif
