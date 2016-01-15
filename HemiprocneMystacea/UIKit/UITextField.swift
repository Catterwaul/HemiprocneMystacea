public extension UITextField {
   final var editingChanged📡: MultiClosure<()> {
      return HemiprocneMystacea.editingChanged📡[self]
   }
   
   final var editingDidEndOnExit📡: MultiClosure<()> {
      return HemiprocneMystacea.editingDidEndOnExit📡[self]
   }
}

private var
   editingChanged📡 = UIControl.Event📦(
      controlEvent: .EditingChanged,
      selector: "onEditingChanged"
   ),
   editingDidEndOnExit📡 = UIControl.Event📦(
      controlEvent: .EditingDidEndOnExit,
      selector: "onEditingDidEndOnExit"
   )

// Won't work if private.
extension UITextField {
   func onEditingChanged() {editingChanged📡[]}
   func onEditingDidEndOnExit() {editingDidEndOnExit📡[]}
}
