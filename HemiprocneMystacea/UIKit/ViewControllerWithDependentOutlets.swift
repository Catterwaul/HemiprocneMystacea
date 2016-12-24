import UIKit


public protocol ViewControllerWithDependentOutlets: class {
	associatedtype OutletDependencies
	
	/// stores dependencies for use in `ViewControllerWithDependentOutlets_viewDidLoad`
	var respondToViewDidLoad: ( () -> Void )? {get set}
	
	var respondToOutletDependencies: (OutletDependencies) -> Void {get set}
	
	func set(outletDependencies: OutletDependencies)
}

public extension ViewControllerWithDependentOutlets where Self: UIViewController {
	func makeRespondToViewDidLoad(outletDependencies: OutletDependencies) {
		respondToViewDidLoad = {
			[unowned self] in self.set(outletDependencies: outletDependencies)
		}
	}
	
	func ViewControllerWithDependentOutlets_viewDidLoad() {
		if let respondToViewDidLoad = respondToViewDidLoad {
			respondToViewDidLoad()
			self.respondToViewDidLoad = nil
		}
		
		respondToOutletDependencies = set(outletDependencies:)
	}
}
