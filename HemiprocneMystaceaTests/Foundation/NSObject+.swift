import Foundation

public extension NSObject {
    public static var className: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}