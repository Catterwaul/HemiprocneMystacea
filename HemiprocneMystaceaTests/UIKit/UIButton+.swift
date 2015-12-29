import UIKit

extension UIButton {
    var disabledAndDim: Bool {
        get {return !enabled}
        set {
            enabled = !newValue
            alpha = newValue ? 0.5 : 1
        }
    }
}