import HM
import Testing

private struct NumericTests {
  @Test func divide() {
    #expect(throws: DivisionByZeroError.self) { try 1 ÷ 0 }
  }

  @Test func squared() {
    let intMaxSquareRoot = Int(Double(Int.max).squareRoot())
    let int = Int.random(in: -intMaxSquareRoot...intMaxSquareRoot)
    #expect(int.squared == int * int)

    let doubleMaxSquareRoot = Double.greatestFiniteMagnitude.squareRoot()
    let double = Double.random(in: -doubleMaxSquareRoot...doubleMaxSquareRoot)
    #expect(double.squared == double * double)
  }

  @Test func toThe() {
    #expect(3.toThe(3 as UInt) == 27)
    #expect(1.toThe(4 as UInt) == 1)
    #expect(5.0.toThe(1 as UInt) == 5)
    #expect(0.toThe(5 as UInt) == 0)
    #expect(0.toThe(0 as UInt) == 1)
  }
}
