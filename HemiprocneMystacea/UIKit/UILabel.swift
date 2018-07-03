import UIKit

public extension UILabel {
  final func hyphenateText() {
    guard let text = text
    else {return}
    
    attributedText = NSMutableAttributedString(
      string: text,
      attributes: [
        NSAttributedString.Key.paragraphStyle: {
          let style = NSMutableParagraphStyle()
          style.hyphenationFactor = 1
          style.alignment = .center
          return style
        } ()
      ]
    )
    lineBreakMode = .byTruncatingTail
  }
}
