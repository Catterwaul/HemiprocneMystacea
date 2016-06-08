public extension NSByteCountFormatter {
   convenience init(includesUnit: Bool) {
      self.init()
      self.includesUnit = includesUnit
   }
}