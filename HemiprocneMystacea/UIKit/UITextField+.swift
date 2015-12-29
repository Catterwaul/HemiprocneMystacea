public extension UITextField {
   func onEditingChanged() {editingChanged📡[]}
   var editingChanged📡: MultiClosure<()> {
      return HemiprocneMystacea.editingChanged📡[self]
   }
   
   func onEditingDidEndOnExit() {editingDidEndOnExit📡[]}
   var editingDidEndOnExit📡: MultiClosure<()> {
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