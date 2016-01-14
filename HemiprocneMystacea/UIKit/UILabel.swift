public extension UILabel {
   final func hyphenateText() {
      guard let text = text else {return}
      
		let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.hyphenationFactor = 1
      paragraphStyle.alignment = .Center
      attributedText = NSMutableAttributedString(
         string: text,
         attributes: [NSParagraphStyleAttributeName: paragraphStyle]
      )
      lineBreakMode = .ByTruncatingTail
	}
}