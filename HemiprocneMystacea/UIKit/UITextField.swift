public extension UITextField {
   final func onEditingChanged() {editingChanged📡[]}
   final var editingChanged📡: MultiClosure<()> {
      return HemiprocneMystacea.editingChanged📡[self]
   }
   
   final func onEditingDidEndOnExit() {editingDidEndOnExit📡[]}
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