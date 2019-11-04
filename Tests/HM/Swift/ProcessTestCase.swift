import HM
import XCTest

final class ProcessTestCase: XCTestCase {
  func test() throws {
    typealias Intermediate = Int
    typealias Final = String

    struct Error: Swift.Error {
      let intermediate: Intermediate
    }

    var intermediate = 1

    func makeFinal(_ intermediate: Intermediate) throws -> Final {
      guard intermediate == 1
      else { throw Error(intermediate: intermediate) }

      return Final(intermediate)
    }

    func async(process: @escaping ProcessGet<Intermediate>) {
      process { intermediate }
    }

    func example(process: @escaping ProcessGet<Final>) {
      async(
        process: makeProcess(processGetError: process) { intermediate in
          try _process(intermediate: intermediate)
        }
      )

      func _process(intermediate: Intermediate) throws {
        process {
          [result = try makeFinal(intermediate)] in
          result
        }
      }
    }

    example { getFinal in
      do {
        let final = try getFinal()
        XCTAssertEqual(final, "\(1)")
      }
      catch { XCTFail("\(error)") }
    }

    intermediate = 2

    example { getFinal in
      do {
        _ = try getFinal()
        XCTFail()
      }
      catch {
        XCTAssertEqual(
          (error as! Error).intermediate,
          2
        )
      }
    }
  }
}
