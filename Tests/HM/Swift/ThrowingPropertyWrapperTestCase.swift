import HM
import XCTest

final class ThrowingPropertyWrapperTestCase: XCTestCase {
  func test_assignmentOperator() {
    let value = "🪕"

    Optional: do {
      var optional: Optional = value

      try? optional = .none.wrappedValue
      XCTAssertNotNil(optional)

      var some = "🎻"
      try? some = optional.wrappedValue
      XCTAssertEqual(some, value)
    }

    Result: do {
      struct Error: Swift.Error { }
      var result = Result<_, Error>.success(value)

      let failure = Result<String, _>.failure(Error())
      try? result.setWrappedValue(failure.wrappedValue)
      XCTAssertEqual(try result.wrappedValue, value)

      var success = "🎻"
      try? success = result.wrappedValue
      XCTAssertEqual(success, value)
    }
  }

  func test_errorMapping() {
    Optional: do {
      let none: Never? = .none
      XCTAssertThrowsError(
        try none.wrappedValue ?! AnyError()
      ) { error in
        XCTAssert(error is AnyError)
      }
    }

    Result: do {
      let result = Result<Never, _>.failure(Never?.UnwrapError())
      XCTAssertThrowsError(
        try result.wrappedValue ?! AnyError()
      ) { error in
        XCTAssert(error is AnyError)
      }
    }
  }

  func test_sequenceOperator() {
    do {
      let array = [1, 3, 5]
      let sequence = Result { array }
      var mapped: [Int] = []
      for element in sequence…? {
        mapped.append(element)
      }
      XCTAssertEqual(mapped, array)
    }

    do {
      let dictionary: [Never: Never]? = nil
      XCTAssert(dictionary…?.isEmpty)
      for (_, _) in dictionary…? { }
    }
  }

  func test_Possible() {
    let value = "🪕"

    Optional: do {
      // @Possible var optional = value
      var optional = Possible(value)

      // optional = value
      optional.setWrappedValue(value)

      // let none: String? = nil
      let none: Possible<String, _> = nil

      // try? optional = none
      try? optional.setWrappedValue(none.wrappedValue)
      XCTAssertEqual(try optional.wrappedValue, value)

      var some = "🎻"
      // try? some = optional
      try? some = optional.wrappedValue
      XCTAssertEqual(some, value)
    }

    Result: do {
      struct Error: Swift.Error { }
      // @Possible<_, Error> var result = value
      var result = Possible<_, Error>(wrappedValue: value)

      // result = value
      result.setWrappedValue(value)

      var failure = result
      // $failure = { throw Error() }
      failure.projectedValue = { throw Error() }

      // try? result = failure
      try? result.setWrappedValue(failure.wrappedValue)
      XCTAssertEqual(try result.wrappedValue, value)

      var success = "🎻"
      // try? success = result
      try? success = result.wrappedValue
      XCTAssertEqual(success, value)
    }
  }
}

// MARK: -
private struct Possible<Value, Error: Swift.Error> {
  var wrappedValue: Value {
    get throws { try projectedValue() }
  }

  mutating func setWrappedValue(_ newValue: Value) {
    projectedValue = { newValue }
  }

  var projectedValue: () throws -> Value

  init(wrappedValue: Value) {
    projectedValue = { wrappedValue }
  }
}

/// Represents that a value was not assigned.
struct PossibleUnwrapError<Value>: Swift.Error & Equatable {
  init() { }
}

extension Possible: ExpressibleByNilLiteral where Error == PossibleUnwrapError<Value> {
  init(nilLiteral: Void) {
    projectedValue = { throw Error() }
  }

  init(_ value: Value) {
    projectedValue = { value }
  }
}
