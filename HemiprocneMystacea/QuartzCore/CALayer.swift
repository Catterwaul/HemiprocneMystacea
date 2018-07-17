import QuartzCore

public extension CALayer {	
	enum KeyPath { }	
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
