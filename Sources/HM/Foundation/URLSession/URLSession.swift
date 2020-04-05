import Foundation

public extension URLSession {
  func makeDataTask<Response: URLResponse>(
    request: URLRequest,
    process: @escaping ( () throws -> (Data?, Response) ) -> Void
  ) -> URLSessionDataTask {
    dataTask(with: request) { data, response, error in
      if let error = error {
        process { throw error }
      }

      process { [response = response as! Response] in (data, response) }
    }
  }

  func makeHTTPDataTask(
    request: URLRequest,
    process: @escaping ( () throws -> (Data?, HTTPURLResponse) ) -> Void
  ) -> URLSessionDataTask {
    makeDataTask(request: request, process: process)
  }
}