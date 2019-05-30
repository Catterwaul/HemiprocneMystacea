import Foundation
import HM
import XCTest

final class URLSessionTestCase: XCTestCase {
  func test_makeHTTPDataTask() {
    let expectation = self.expectation(description: "")
    defer { waitForExpectations(timeout: 5) }

    URLSession.shared.makeHTTPDataTask(
      request: URLRequest(
        url: {
          var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
          urlComponents.queryItems = [
            "media": "music",
            "entity": "song",
            "term": "Rescue Song",
            "attribute": "songTerm"
          ]
          return urlComponents.url!
        } ()
      )
    ) { getDataAndResponse in
      defer { expectation.fulfill() }

      do {
        struct JSON: Decodable {
          enum CodingKeys: String, CodingKey {
            case tracks = "results"
          }

          let tracks: [Track]
        }

        struct Track: Decodable {
          let artistName: String
        }


        let (data, response) = try getDataAndResponse()
        let json = try JSONDecoder().decode(JSON.self, from: data!)

        XCTAssertEqual(response.statusCode, 200)
        XCTAssertTrue(
          json.tracks.map { $0.artistName } .contains("Mr Little Jeans")
        )
      }
      catch { XCTFail("\(error)") }
    }
      .resume()
  }
}
