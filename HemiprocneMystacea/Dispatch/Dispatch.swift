import Dispatch

public func dispatchToMainQueue(ƒ: () -> ()) {
	dispatch_async(dispatch_get_main_queue(), ƒ)
}