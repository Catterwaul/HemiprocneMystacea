public extension UIAlertAction {
  @nonobjc static let `default` = UIAlertAction(title: "OK")
  
  convenience init(
    title: String? = nil,
    style: UIAlertActionStyle = .default,
    📻selection: () -> () = {}
  ) {
    self.init(
      title: title,
      style: style,
      handler: {_ in 📻selection()}
    )
  }
}
