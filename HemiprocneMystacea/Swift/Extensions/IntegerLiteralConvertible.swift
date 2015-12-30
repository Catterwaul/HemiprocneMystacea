extension IntegerLiteralConvertible where Self: IntegerArithmeticType {
    func divisible(by divisor: Self) -> Bool {return self % divisor == 0}
}