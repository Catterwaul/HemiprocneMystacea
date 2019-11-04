public extension Strideable where Stride: SignedInteger {
  func clamped(to limits: Range<Self>) -> Self {
    clamped( to: ClosedRange(limits) )
  }
}
