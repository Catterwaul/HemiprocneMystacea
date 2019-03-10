import UIKit

public extension UINib {
  static func instantiate<Object: AnyObject>(owner: Any? = nil) -> Object? {
    return
      Bundle(for: Object.self)
      .loadNibNamed("\(Object.self)", owner: owner)?
      .first { $0 is Object } as? Object
  }
}
