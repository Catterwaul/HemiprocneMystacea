public extension NSByteCountFormatter {
   convenience init(includesUnit: Bool) {
      self.init()
      self.includesUnit = includesUnit
   }
   
   /// `stringFromByteCount`, if it took anything that can be converted to an Int64
   func String<Integer: Int64🎀>(byteCount: Integer) -> Swift.String {
      return stringFromByteCount(byteCount.Int64)
   }
}