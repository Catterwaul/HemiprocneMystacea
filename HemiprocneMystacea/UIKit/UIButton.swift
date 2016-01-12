public extension UIButton {
   /// A simple way to visibily show that a user interaction is disabled
   var disabledAndDim: Bool {
      get {return !enabled}
      set {
         enabled = !newValue
         alpha = newValue ? 0.5 : 1
      }
   }
}