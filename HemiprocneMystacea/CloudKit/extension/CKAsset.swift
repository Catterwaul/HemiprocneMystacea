import CloudKit
import UIKit

public extension UIImage {
	convenience init?(asset: CKAsset) {
    guard let fileURL = asset.fileURL
    else { return nil }

		do {
      let data = try Data(contentsOf: fileURL)
      
			self.init(data: data)
		}
		catch { return nil }
	}
}
