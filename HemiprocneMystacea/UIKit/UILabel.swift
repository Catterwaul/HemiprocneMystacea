public extension UILabel {
   final func hyphenateText() {
      guard let text = text else {return}
      
		let paragraphStyle = NSMutableParagraphStyle()…{
         $0.hyphenationFactor = 1
         $0.alignment = .Center
      }
      attributedText = NSMutableAttributedString(
         string: text,
         attributes: [NSParagraphStyleAttributeName: paragraphStyle]
      )
      lineBreakMode = .ByTruncatingTail
	}
}