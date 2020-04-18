import Foundation

public extension Selector {
  /// Wraps a closure in a `Selector`.
  /// - Note: Callable as a function.
  final class Perform: NSObject {
    init(_ perform: @escaping () -> Void) {
      self.perform = perform
      super.init()
    }

    var selector: Selector { #selector(callAsFunction) }
    @objc func callAsFunction() { perform() }
    private let perform: () -> Void
  }
}
