import Foundation

public extension URLSession {
  func makeDataTask<Response: URLResponse>(
    request: URLRequest,
    process: @escaping (URLSessionDataTask.Result<Response>) -> Void
  ) -> URLSessionDataTask {
    dataTask(with: request) {
      process( .init(data: $0, response: $1, error: $2) )
    }
  }

  func makeHTTPDataTask(
    request: URLRequest,
    process: @escaping (URLSessionDataTask.Result<HTTPURLResponse>) -> Void
  ) -> URLSessionDataTask {
    makeDataTask(request: request, process: process)
  }
}

public extension URLSessionDataTask {
  typealias Result<Response: URLResponse> =
    Swift.Result<(data: Data?, response: Response), Error>
}

public extension URLSessionDataTask.Result {
  /// - Throws: `CastError.impossible` if  `response` is not a `Response`.
  init<Response: URLResponse>(
    data: Data?, response: URLResponse?,
    error: Failure?
  )
  where Success == (data: Data?, response: Response) {
    try! self.init(
      success: (response as? Response).map { (data, $0) },
      failure: error
    )
  }
}
