import UIKit

protocol ViewControllerWithDependentOutlets: class {
	associatedtype OutletDependencies
	
	var respondToViewDidLoad: UIViewController.RespondToViewDidLoad? {get set}
	
	var respondToOutletDependencies: (OutletDependencies) -> Void {get set}
	
	func set_outletDependencies(_: OutletDependencies)
}

extension ViewControllerWithDependentOutlets where Self: UIViewController {
	func intialize_respondToViewDidLoad(outletDependencies: OutletDependencies) {
		respondToViewDidLoad = {
			[unowned self] in self.set_outletDependencies(outletDependencies)
		}
	}
	
	func ViewControllerWithDependentOutlets_viewDidLoad() {
		if let respondToViewDidLoad = respondToViewDidLoad {
			respondToViewDidLoad()
			self.respondToViewDidLoad = nil
		}
		
		respondToOutletDependencies = set_outletDependencies
	}
}
