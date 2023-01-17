#if canImport(GameController)
import typealias GameController.GCController

public extension GCController {
  final var isRemote: Bool { extendedGamepad == nil }
}
#endif
