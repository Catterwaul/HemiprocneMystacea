import Foundation

public struct FileInfo {
	init(path: String) throws {
		try attributes = FileManager.default.attributesOfItem(atPath: path)
	}

	fileprivate let attributes: [FileAttributeKey: Any]
}

//MARK: public
public extension FileInfo {
	var size: UInt {
		return attributes[.size] as! UInt
	}
}
