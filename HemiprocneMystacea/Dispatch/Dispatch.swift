import Dispatch;

public func dispatchToMainQueue(ƒ: () -> ()) {
	dispatch_async(dispatch_get_main_queue(), ƒ)
}

/// There's no way to extend the Dispatch namespace, but this fakes it.
public struct Dispatch {
	///- Parameter concurrent: If false, a serial queue is returned.
	func Queue(
		label label: String,
		concurrent: Bool,
		qualityOfService: qos_class_t,
		relativePriority: Int32 = 0
	) -> dispatch_queue_t {
		return dispatch_queue_create(
			label,
			dispatch_queue_attr_make_with_qos_class(
				concurrent
					? DISPATCH_QUEUE_CONCURRENT
					: DISPATCH_QUEUE_SERIAL,
				qualityOfService,
				relativePriority
			)
		)
	}
}