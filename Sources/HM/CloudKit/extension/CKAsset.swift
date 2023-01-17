#if canImport(UIKit)
import typealias CloudKit.CKAsset
import typealias UIKit.UIImage

public extension UIImage {
	convenience init?(asset: CKAsset) throws {
    guard let fileURL = asset.fileURL else { return nil }
    
    self.init(data: try .init(contentsOf: fileURL))
	}
}

#endif
