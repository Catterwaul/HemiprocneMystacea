import HM
import XCTest

final class ArrayTestCase: XCTestCase {
  func test_splitInHalf() {
    let intsSplitInHalf = [1, 2, 3, 4, 5].splitInHalf
    
    XCTAssertEqual(intsSplitInHalf[0], [1, 2])
    XCTAssertEqual(intsSplitInHalf[1], [3, 4, 5])
  }
  
  func test_getElement() {
    XCTAssertThrowsError( try ["🐾", "🥝"].getElement(index: 2) )
    
    let optionals = [1, 2, nil]
    
    do {
      let optional1 = try optionals.getElement(index: 0)
      XCTAssertEqual(optional1, 1)
    }
    catch {XCTFail()}
    
    let outOfBoundsIndex = optionals.count
    do {
      _ = try optionals.getElement(index: outOfBoundsIndex)
      XCTFail()
    }
    catch let error as Array<Int?>.OutOfBoundsError {
      XCTAssertEqual(error.index, outOfBoundsIndex)
    }
    catch {XCTFail()}
  }
}
