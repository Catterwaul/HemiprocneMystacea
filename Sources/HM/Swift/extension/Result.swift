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

  /// `success` for `Optional.some`s; `failure` for `.none`s.
  init(
    success: Success?,
    failure: @autoclosure () -> Failure
  ) {
    self = success.map(Self.success) ?? .failure(failure())
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
}

public extension Result {
  init(catching success: () async throws(Failure) -> Success) async {
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
  /// - Throws: if the error thrown is not a `Failure`,
  /// or a `Failure.ArrayLiteralElement`.
  init(groupingFailures getSuccess: @autoclosure () throws -> Success) throws(CastError) {
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
        throw .init()
      }
    }
  }
}

public extension Result where Success == Void {
  /// `.success` only when `failure` is `nil`.
  init(failure: Failure?) {
    self = failure.map(Self.failure) ?? .success(())
  }
}
