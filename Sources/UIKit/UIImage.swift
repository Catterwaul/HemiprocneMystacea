import UIKit

public extension UIImage {
	func hasEqualPixels(_ image: UIImage) -> Bool {
		func data(of image: UIImage) -> Data? {
			return image.cgImage?.dataProvider?.data as Data?
		}
		
    return data(of: self) == data(of: image)
	}
}

public extension KeyedDecodingContainer {
  func decode(key: Key) throws -> UIImage {
    guard let image = UIImage(data: try decode(Data.self, forKey: key))
    else {
      throw DecodingError.dataCorrupted(
        DecodingError.Context(
          codingPath: [key],
          debugDescription: "Data does not represent a 'UIImage'"
        )
      )
    }
    
    return image
  }
}

public extension KeyedEncodingContainer {
  mutating func encode(_ image: UIImage, forKey key: Key) throws {
    guard let data = image.pngData()
    else {
      throw EncodingError.invalidValue(
        image,
        EncodingError.Context(
          codingPath: [key],
          debugDescription: "Image cannot be represented with PNG data"
        )
      )
    }
    
    try encode(data, forKey: key)
  }
}
