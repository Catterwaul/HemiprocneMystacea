public protocol BitShiftable: Integer {
   static func << (value: Self, bitShift: Self) -> Self
   static func >> (value: Self, bitShift: Self) -> Self
}

extension Int: BitShiftable {}
extension UInt: BitShiftable {}
