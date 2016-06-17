public protocol BitShiftable: Integer {
   func << (value: Self, bitShift: Self) -> Self
   func >> (value: Self, bitShift: Self) -> Self
}

extension Int: BitShiftable {}
extension UInt: BitShiftable {}
