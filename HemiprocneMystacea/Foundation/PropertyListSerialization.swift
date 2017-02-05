import Foundation

extension PropertyListSerialization{
  static func makePropertyList(
    data: Data,
    format: PropertyListFormat = .xml
  ) throws -> [ [String: Any] ] {
    var format = format
    let propertyList = try self.propertyList(
      from: data,
      format: &format
    )
    
    guard let dictionary = propertyList as? [ [String: Any] ]
    else {
      struct Error: Swift.Error {}
      throw Error()
    }
    
    return dictionary
  }
}
