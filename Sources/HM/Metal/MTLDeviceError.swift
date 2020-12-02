import Metal

// MARK: -

/// A namespace for nested types within `MTLDevice`.
public enum MTLDeviceExtensions {
  public enum Error: Swift.Error {
    case noSystemDefaultDevice
    case couldNotMakeCommandQueue
  }
}

extension MTLDeviceExtensions.Error: CustomStringConvertible {
  public var description: String {
    switch self {
    case .noSystemDefaultDevice:
      return "Error: Could not create reference to preferred system default Metal device."
    case .couldNotMakeCommandQueue:
      return "Error: Could not create serial command submission queue."
    }
  }
}
