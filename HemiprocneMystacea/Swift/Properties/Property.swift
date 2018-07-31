public protocol Property: AnyObject {
  associatedtype Value
  
  var value: Value { get set }
}
