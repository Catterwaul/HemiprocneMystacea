import typealias Combine.Future

public extension Result {
  /// Create an Objective-C-style "completion handler".
  static func makeHandleCompletion(
    _ process: @escaping (Self) -> Void
  ) -> (Success?, Failure?) -> Void {
    { success, failure in
      process(failure.map(Self.failure) ?? .success(success!))
    }
  }

  /// Create an Objective-C-style "completion handler".
  static func makeHandleCompletion<FinalSuccess>(
    processSuccess: @escaping (Success) -> Void,
    processFailure: @escaping Future<FinalSuccess, Failure>.Promise
  ) -> (Success?, Failure?) -> Void {
    makeHandleCompletion(
      makePromise(
        processSuccess: processSuccess,
        processFailure: processFailure
      )
    )
  }

  static func makePromise<FinalSuccess>(
    processSuccess: @escaping (Success) -> Void,
    processFailure: @escaping Future<FinalSuccess, Failure>.Promise
  ) -> Future<Success, Failure>.Promise {
    { result in
      switch result {
      case .success(let success):
        processSuccess(success)
      case .failure(let error):
        processFailure(.failure(error))
      }
    }
  }

  /// Create a `Result` based on a throwing operation.
  /// - Throws: `CastError.impossible` if the error thrown is not a `Failure`.
  init(_ getSuccess: @autoclosure () throws -> Success) throws {
    do {
      self = .success(try getSuccess())
    } catch {
      guard let failure = error as? Failure else { throw CastError.impossible }
      self = .failure(failure)
    }
  }

  /// `success` for `Optional.some`s; `failure` for `.none`s.
  init(
    success: Success?,
    failure: @autoclosure () -> Failure
  ) {
    self =
      success.map(Self.success)
      ?? .failure(failure())
  }

  /// - Throws: OneOfTwo<Success, Failure>.Error
  init(success: Success?, failure: Failure?) throws {
    switch try OneOfTwo(success, failure) {
    case .option0(let success):
      self = .success(success)
    case .option1(let failure):
      self = .failure(failure)
    }
  }

  /// A version of `get` that allows for processing a strongly-typed error, upon failure.
  func get(_ catch: (Failure) -> Void) -> Success? {
    switch self {
    case .success(let success):
      return success
    case .failure(let failure):
      `catch`(failure)
      return nil
    }
  }
}

public extension Result where Failure == Error {
  init(catching success: () async throws -> Success) async {
    do {
      self = .success(try await success())
    } catch {
      self = .failure(error)
    }
  }
}

public extension Result where Failure: Sequence & ExpressibleByArrayLiteral {
  /// Create a `Result` based on a throwing operation.
  ///
  /// If only one element is thrown, it will be turned into a `Success Sequence`.
  ///
  /// - Throws: `CastError.impossible` if the error thrown is not a `Failure`,
  /// or a `Failure.ArrayLiteralElement`.
  init(groupingFailures getSuccess: @autoclosure () throws -> Success) throws {
    do {
      let success = try getSuccess()
      self = .success(success)
    } catch {
      switch error {
      case let failure as Failure:
        self = .failure(failure)
      case let element as Failure.ArrayLiteralElement:
        self = .failure([element])
      default:
        throw CastError.impossible
      }
    }
  }
}

// MARK: -

public extension Result where Success == Void {
  /// `.success(())`
  static var success: Self { .success(()) }

  /// `.success` only when `failure` is `nil`.
  init(failure: Failure?) {
    self = failure.map(Self.failure) ?? .success
  }
}
