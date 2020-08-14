import HM
import XCTest
import struct MapKit.MKCoordinateRegion

final class MKCoordinateRegionTestCase: XCTestCase {
  func test() throws {
    let region = MKCoordinateRegion(
      center: .init(latitude: 1, longitude: 2),
      latitudinalMeters: 3,
      longitudinalMeters: 4
    )

    XCTAssertEqual(
      region,
      try JSONDecoder().decode(
        MKCoordinateRegion.self,
        from: JSONEncoder().encode(region)
      )
    )
  }
}
