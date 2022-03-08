#if !os(watchOS)
import Metal

public enum MTLDeviceError: Error {
  case noSystemDefaultDevice
  case couldNotMakeCommandQueue
}

extension MTLDeviceError: CustomStringConvertible {
  public var description: String {
    switch self {
    case .noSystemDefaultDevice:
      return "Error: Could not create reference to preferred system default Metal device."
    case .couldNotMakeCommandQueue:
      return "Error: Could not create serial command submission queue."
    }
  }
}
#endif
