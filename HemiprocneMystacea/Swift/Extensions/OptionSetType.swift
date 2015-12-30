extension OptionSetType where RawValue: BitShiftable {
   init(bit: RawValue) {
      self.init(rawValue: bit <= 1 ? bit : 1 << (bit - 1))
   }
   
   static func BitFlags(startingFlag startingFlag: RawValue)
   -> (Self, Self) {
      return (
         Self(bit: startingFlag),
         Self(bit: startingFlag + 1)
      )
   }
   
   static func BitFlags(startingFlag startingFlag: RawValue)
   -> (Self, Self, Self) {
      return (
         Self(bit: startingFlag),
         Self(bit: startingFlag + 1),
         Self(bit: startingFlag + 2)
      )
   }
   
   static func BitFlags(startingFlag startingFlag: RawValue)
   -> (Self, Self, Self, Self) {
      return (
         Self(bit: startingFlag),
         Self(bit: startingFlag + 1),
         Self(bit: startingFlag + 2),
         Self(bit: startingFlag + 3)
      )
   }
}
