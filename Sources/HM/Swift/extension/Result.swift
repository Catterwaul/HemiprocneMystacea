public extension Result {
  /// `success` for `Optional.some`s; `failure` for `.none`s.
  init(
    success: Success?,
    failure getFailure: @autoclosure () -> Failure
  ) {
    self =
      success.map(Self.success)
      ?? .failure( getFailure() )
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

//MARK:-

/// A `Result` with no useful success value.
public typealias VerificationResult = Result<Void, Error>

public extension VerificationResult where Success == Void {
  /// `.success( () )`
  init() {
    self = .success( () )
  }

  /// `.success` only when `failure` is `nil`.
  init(failure: Failure?) {
    switch failure {
    case nil:
      self.init()
    case let failure?:
      self = .failure(failure)
    }
  }
}
