import UIKit

public extension UIImage {
	func hasEqualPixels(to image: UIImage) -> Bool {
		func getData(from: UIImage) -> Data? {
			return image.cgImage?.dataProvider?.data as Data?
		}
		
		return getData(from: self) == getData(from: image)
	}
}
