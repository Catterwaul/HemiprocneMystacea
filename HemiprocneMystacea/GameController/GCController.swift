import class GameController.GCController

public extension GCController {
  final var isRemote: Bool { extendedGamepad == nil }
}
