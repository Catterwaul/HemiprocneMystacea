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
        try none.wrappedValue ?? AnyError().throw()
      ) { error in
        XCTAssert(error is AnyError)
      }
    }

    Result: do {
      let result = Result<Never, _>.failure(Never?.UnwrapError())
      XCTAssertThrowsError(
        try result.wrappedValue ?? AnyError().throw()
      ) { error in
        XCTAssert(error is AnyError)
      }
    }
  }

  func test_coalescing() {
    Error: do {
      let value: Optional = "🪙"
      let none = nil as String?

      XCTAssertEqual(
        try none.wrappedValue ?? value.wrappedValue,
        value
      )

      XCTAssertThrowsError(
        try none.wrappedValue ?? AnyError().throw()
      )
    }

    Result: do {
      typealias Result = Swift.Result<Bool, AnyError>
      let success = Result.success(true)
      let failure = Result.failure(.init())
      XCTAssertEqual(failure ?? failure ?? success, success)
    }

    GetThrowsMutatingSet: do {
      typealias Property = GetThrowsMutatingSet<Bool, AnyError>
      let success = Property { true }
      let failure = Property { throw AnyError() }
      XCTAssertTrue(try (failure ?? failure ?? success).wrappedValue)
    }
  }

  func test_reduce() {
    var int: Int? = nil
    XCTAssertEqual(int.reduce(1, +), 1)

    int = 2
    XCTAssertEqual(int.reduce(1, +), 3)

    struct Error: Swift.Error { }
    var arrayResult = Result<[Int], _>.failure(Error())
    let array: [Int] = [1, 2]

    XCTAssertEqual(
      arrayResult.reduce(array) { $1 + $0 },
      array
    )

    arrayResult = .success([0])
    XCTAssertEqual(
      arrayResult.reduce(array) { $1 + $0 },
      [0, 1, 2]
    )
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
      var optional = GetThrowsMutatingSet(value)

      // optional = value
      optional.setWrappedValue(value)

      // let none: String? = nil
      let none: GetThrowsMutatingSet<String, _> = nil

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
      var result = GetThrowsMutatingSet<_, Error>(wrappedValue: value)

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

/// Represents that a value was not assigned.
public struct PossibleUnwrapError<Value>: Swift.Error & Equatable {
  init() { }
}

extension GetThrowsMutatingSet: ExpressibleByNilLiteral where Error == PossibleUnwrapError<Value> {
  public init(nilLiteral: Void) {
    self.init { throw Error() }
  }

  init(_ value: Value) {
    self.init { value }
  }
}
