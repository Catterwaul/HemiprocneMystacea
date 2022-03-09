import ModelIO

public extension MDLVertexDescriptor {
  /// A type-safe versions of `attributes`.
  var attributeArray: [MDLVertexAttribute] {
    get { attributes as! [MDLVertexAttribute] }
    set { attributes = newValue as! NSMutableArray }
  }

  /// A type-safe versions of `layouts`.
  var layoutArray: [MDLVertexBufferLayout] {
    get { layouts as! [MDLVertexBufferLayout] }
    set { layouts = newValue as! NSMutableArray }
  }
}
