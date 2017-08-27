import CloudKit
import UIKit

public extension UIImage {
	convenience init?(asset: CKAsset) {
		do {
      let data = try Data(contentsOf: asset.fileURL)
      
			self.init(data: data)
		}
		catch {return nil}
	}
}
