import UIKit

extension UITextField {
   func onEditingChanged() {editingChanged📡[]}
   var editingChanged📡: MultiClosure<()> {
      return uLOD.editingChanged📡[self]
   }
   
   func onEditingDidEndOnExit() {editingDidEndOnExit📡[]}
   var editingDidEndOnExit📡: MultiClosure<()> {
      return uLOD.editingDidEndOnExit📡[self]
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