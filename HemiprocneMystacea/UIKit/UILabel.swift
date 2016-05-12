public extension UILabel {
	final func hyphenateText() {
		guard let text = text
		else {return}
		
		attributedText = NSMutableAttributedString(
			string: text,
			attributes: [
				NSParagraphStyleAttributeName: NSMutableParagraphStyle()…{
					$0.hyphenationFactor = 1
					$0.alignment = .Center
				}
			]
		)
		lineBreakMode = .ByTruncatingTail
	}
}