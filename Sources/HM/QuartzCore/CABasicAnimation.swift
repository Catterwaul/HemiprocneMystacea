#if !os(watchOS)
import QuartzCore

public extension CABasicAnimation {
  convenience init(
    keyPath: String,
    values: Values,
    duration: CFTimeInterval
  ) {
    self.init(keyPath: keyPath)
    
    fromValue = values.from
    toValue = values.to
    
    self.duration = duration
  }
}
#endif
