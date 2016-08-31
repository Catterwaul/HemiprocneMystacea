import CloudKit
import UIKit

public extension UIImage {
	convenience init?(asset: CKAsset) {
		do {
			self.init(
				data: try Data(contentsOf: asset.fileURL)
			)
		}
		catch {return nil}
	}
}
