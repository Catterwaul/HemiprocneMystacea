public protocol injectDependencies {
	associatedtype Dependencies
	
	func inject(dependencies: Dependencies)
}
