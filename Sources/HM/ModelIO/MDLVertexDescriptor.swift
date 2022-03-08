import ModelIO

public extension MDLVertexDescriptor {
  /// A type-safe versions of `attributes`.
  var attributeArray: [MDLVertexAttribute] {
    get { attributes as! [MDLVertexAttribute] }
    set { attributes = newValue as! NSMutableArray }
  }
}
