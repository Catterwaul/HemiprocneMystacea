protocol BitShiftable: IntegerType {
   func <<(value: Self, bitShift: Self) -> Self
   func >>(value: Self, bitShift: Self) -> Self
}

extension UInt: BitShiftable {}