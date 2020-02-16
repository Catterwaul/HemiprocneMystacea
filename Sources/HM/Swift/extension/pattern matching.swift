public func ~= <Value>(
  matchPattern: (Value) -> Bool,
  value: Value
) -> Bool {
  matchPattern(value)
}
