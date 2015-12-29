struct FileInfo {
	init(path: String) throws {
		try attributes = NSFileManager.defaultManager().attributesOfItemAtPath(path)
	}
	
	private let attributes: [String: AnyObject]
	
	var size: UInt {return attributes[NSFileSize] as! UInt}
}