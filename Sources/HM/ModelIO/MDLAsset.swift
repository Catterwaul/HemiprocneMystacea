#if canImport(ModelIO)
import ModelIO

public extension MDLAsset {
  /// `childObjects(of: Object.self) as! [Object]`
  func children<Object: MDLObject>() -> [Object] {
    childObjects(of: Object.self) as! [Object]
  }
}
#endif
