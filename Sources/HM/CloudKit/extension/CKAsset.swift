#if !os(macOS)

import CloudKit
import UIKit

public extension UIImage {
	convenience init?(asset: CKAsset) throws {
    guard let fileURL = asset.fileURL else { return nil }
    
    self.init(data: try .init(contentsOf: fileURL))
	}
}

#endif
