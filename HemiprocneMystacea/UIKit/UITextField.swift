public extension UITextField {
  final var editingChanged📡: MultiClosure<()> {
    return HemiprocneMystacea.editingChanged📡[self]
  }
  
  final var editingDidEndOnExit📡: MultiClosure<()> {
    return HemiprocneMystacea.editingDidEndOnExit📡[self]
  }
}

private var editingChanged📡 = UIControl.Event📦(
  controlEvent: .EditingChanged,
  selector: #selector(UITextFieldSelectors.onEditingChanged)
)
private var editingDidEndOnExit📡 = UIControl.Event📦(
  controlEvent: .EditingDidEndOnExit,
  selector: #selector(UITextFieldSelectors.onEditingDidEndOnExit)
)

// Won't work if private.
extension UITextField {
  func onEditingChanged() {
    editingChanged📡[]
  }
  func onEditingDidEndOnExit() {
    editingDidEndOnExit📡[]
  }
}
@objc private protocol UITextFieldSelectors {
  func onEditingChanged()
  func onEditingDidEndOnExit()
}