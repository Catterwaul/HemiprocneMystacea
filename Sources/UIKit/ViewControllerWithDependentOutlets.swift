#if !os(macOS)
import UIKit

public protocol ViewControllerWithDependentOutlets: UIViewController {
  associatedtype OutletDependencies
  
  /// Stores dependencies for use in `ViewControllerWithDependentOutlets_viewDidLoad`.
  /// 
  /// Don't manually give it a value; 
  /// instead, let `respondToOutletDependencies` do that.
  var respondToViewDidLoad: (() -> Void )? { get set }
  
  /// - Important: 
  /// 1. Make this a `lazy var`.
  /// 2. Assign `assignInjectToRespondToViewDidLoad` to it.
  var respondToOutletDependencies: (OutletDependencies) -> Void { get set }
  
  func inject(outletDependencies: OutletDependencies)
}

public extension ViewControllerWithDependentOutlets  {
  /// - Parameter outletDependencies: Passed in before `viewDidLoad`,
  /// probably using a storyboard segue.
  ///
  /// - Returns: The initial value for `respondToOutletDependencies`,
  /// which assigns `inject(outletDependencies:)` to `respondToViewDidLoad`,
  /// using the `outletDependencies` argument.
  func assignInjectToRespondToViewDidLoad(outletDependencies: OutletDependencies) {
    respondToViewDidLoad = { [unowned self] in
      self.inject(outletDependencies: outletDependencies)
    }
  }
  
  /// Like a `super.viewDidLoad` for `ViewControllerWithDependentOutlets`.
  /// * If `respondToViewDidLoad` is not nil…
  ///	1. Calls `respondToViewDidLoad`.
  ///	2. Sets `respondToViewDidLoad` to `nil`.
  /// * Sets `respondToOutletDependencies` to `inject(outletDependencies:)`
  func ViewControllerWithDependentOutlets_viewDidLoad() {
    if let respondToViewDidLoad = respondToViewDidLoad {
      respondToViewDidLoad()
      self.respondToViewDidLoad = nil
    }
    
    respondToOutletDependencies = inject(outletDependencies:)
  }
}
#endif
