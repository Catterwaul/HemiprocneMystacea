import UIKit

public protocol ViewControllerWithDependentOutlets: class {
	associatedtype OutletDependencies
	
	var respondToViewDidLoad: (() -> Void)? {get set}
	
	var respondToOutletDependencies: (OutletDependencies) -> Void {get set}
	
	func setOutletDependencies(_: OutletDependencies)
}

public extension ViewControllerWithDependentOutlets where Self: UIViewController {
	func intialize_respondToViewDidLoad(outletDependencies: OutletDependencies) {
		respondToViewDidLoad = {
			[unowned self] in self.setOutletDependencies(outletDependencies)
		}
	}
	
	func ViewControllerWithDependentOutlets_viewDidLoad() {
		if let respondToViewDidLoad = respondToViewDidLoad {
			respondToViewDidLoad()
			self.respondToViewDidLoad = nil
		}
		
		respondToOutletDependencies = setOutletDependencies
	}
}
