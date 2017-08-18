import UIKit

public extension UIImage {
	func hasEqualPixels(_ image: UIImage) -> Bool {
		func getData(_ image: UIImage) -> Data? {
			return image.cgImage?.dataProvider?.data as Data?
		}
		
		return getData(self) == getData(image)
	}
}
