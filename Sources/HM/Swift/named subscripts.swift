/// An emulation of the missing Swift feature of named subscripts.
/// - Note: Argument labels are not supported.
public struct ObjectSubscript<Object: AnyObject, Index, Value> {
  public typealias Get = (Object) -> (Index) -> Value
  public typealias Set = (Object, Index, Value) -> Void

  public unowned var object: Object
  public var get: Get
  public var set: Set
}

public extension ObjectSubscript {
  init(
    _ object: Object,
    get: @escaping Get,
    set: @escaping Set
  ) {
    self.object = object
    self.get = get
    self.set = set
  }

  subscript(index: Index) -> Value {
    get { get(object)(index) }
    nonmutating set { set(object, index, newValue) }
  }
}

/// An emulation of the missing Swift feature of named subscripts.
/// - Note: Argument labels are not supported.
public struct ValueSubscript<Root, Index, Value> {
  public typealias Pointer = UnsafeMutablePointer<Root>
  public typealias Get = (Root) -> (Index) -> Value
  public typealias Set = (inout Root, Index, Value) -> Void

  public var pointer: Pointer
  public var get: Get
  public var set: Set
}

public extension ValueSubscript {
  init(
    _ pointer: Pointer,
    get: @escaping Get,
    set: @escaping Set
  ) {
    self.pointer = pointer
    self.get = get
    self.set = set
  }

  subscript(index: Index) -> Value {
    get { get(pointer.pointee)(index) }
    nonmutating set { set(&pointer.pointee, index, newValue) }
  }
}

/// An emulation of the missing Swift feature of named subscripts.
/// - Note: Argument labels are not supported.
public struct NamedGetOnlySubscript<Index, Value> {
  public typealias GetValue = (Index) -> Value
  
//MARK: private
  private let getValue: GetValue
}

public extension NamedGetOnlySubscript {
  /// - Parameter getValue: Provide a `Value` for an `Index`.
  init(_ getValue: @escaping GetValue) {
    self.getValue = getValue
  }
  
  subscript(index: Index) -> Value { getValue(index) }
  
  subscript<Indices: Sequence>(indices: Indices) -> [Value]
  where Indices.Element == Index {
    indices.map { self[$0] }
  }
  
  subscript(indices: Index...) -> [Value] { self[indices] }
}
