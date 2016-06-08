public extension Dispatch {
	enum globalQueues {}
}

//MARK: public
public extension Dispatch.globalQueues {
	static var background: dispatch_queue_t {
		return globalQueue(QOS_CLASS_BACKGROUND)
	}
	static var userInitiated: dispatch_queue_t {
		return globalQueue(QOS_CLASS_USER_INITIATED)
	}
	static var utility: dispatch_queue_t {
		return globalQueue(QOS_CLASS_UTILITY)
	}
}

//MARK: private
private extension Dispatch.globalQueues {
	/// Usage woud ideally look like:
	///```
	/// Dispatch.GlobalQueue[qualityOfService]
	///```
	static func globalQueue(qualityOfService: qos_class_t) -> dispatch_queue_t {
		return dispatch_get_global_queue(qualityOfService, 0)
	}
}