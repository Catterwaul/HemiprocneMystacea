import class GameController.GCController

public extension GCController {
  final var isRemote: Bool {
    return gamepad == nil
  }
}
