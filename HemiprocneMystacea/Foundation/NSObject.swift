public extension NSObject {
   static var className: String {
      // This only works with NSObjects.
      return NSStringFromClass(self).componentsSeparatedByString(".").last!
   }
}