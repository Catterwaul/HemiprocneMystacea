import QuartzCore

public extension CATransaction {
  static func changePropertiesWithoutAnimation(_ changeProperties: () -> Void) {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    changeProperties()
    CATransaction.commit()
  }
}
