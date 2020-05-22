import Foundation

public extension URLSession {
  typealias DataTaskResult<Response: URLResponse> =
    Result<(data: Data?, response: Response), Error>

  func makeDataTask<Response: URLResponse>(
    request: URLRequest,
    process: @escaping (DataTaskResult<Response>) -> Void
  ) -> URLSessionDataTask {
    dataTask(with: request) { data, response, error in
      process(
        try! Result(
          success: (response as? Response).map { (data, $0) },
          failure: error
        )
      )
    }
  }

  func makeHTTPDataTask(
    request: URLRequest,
    process: @escaping (DataTaskResult<HTTPURLResponse>) -> Void
  ) -> URLSessionDataTask {
    makeDataTask(request: request, process: process)
  }
}
