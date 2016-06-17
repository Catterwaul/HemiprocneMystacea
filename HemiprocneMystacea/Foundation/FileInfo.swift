struct FileInfo {
	init(path: String) throws {
		try attributes = FileManager.default().attributesOfItem(atPath: path)
	}

	private let attributes: [String: AnyObject]
}

//MARK: public
extension FileInfo {
	var size: UInt {
		return attributes[FileAttributeKey.size.rawValue] as! UInt
	}
}
