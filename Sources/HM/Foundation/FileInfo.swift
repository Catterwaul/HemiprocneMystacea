import Foundation

public struct FileInfo {
  private let attributes: [FileAttributeKey: Any]
}

//MARK: public
public extension FileInfo {
  init(path: String) throws {
    try attributes = FileManager.default.attributesOfItem(atPath: path)
  }
  
	var size: UInt { attributes[.size] as! UInt }
}
