public extension Strideable where Stride: SignedInteger {
  func clamped(to limits: Range<Self>) -> Self {
    return self.clamped( to: ClosedRange(limits) )
  }
}
