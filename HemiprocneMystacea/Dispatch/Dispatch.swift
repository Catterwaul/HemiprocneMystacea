import Dispatch; public struct Dispatch {
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

public extension Dispatch {enum GlobalQueue {}}
public extension Dispatch.GlobalQueue {
	static var background: dispatch_queue_t {return `subscript`(QOS_CLASS_BACKGROUND)}
	static var userInitiated: dispatch_queue_t {return `subscript`(QOS_CLASS_USER_INITIATED)}
	static var utility: dispatch_queue_t {return `subscript`(QOS_CLASS_UTILITY)}
}
private extension Dispatch.GlobalQueue {
	/// Usage woud ideally look like:
	///```
	/// Dispatch.GlobalQueue[qualityOfService]
	///```
	static func `subscript`(qualityOfService: qos_class_t) -> dispatch_queue_t {
		return dispatch_get_global_queue(qualityOfService, 0)
	}
}

public func dispatchToMainQueue(ƒ: () -> ()) {
	dispatch_async(dispatch_get_main_queue(), ƒ)
}