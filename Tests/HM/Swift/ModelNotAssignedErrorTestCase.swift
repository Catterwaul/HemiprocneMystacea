import HM
import XCTest

final class ModelNotAssignedErrorTestCase: XCTestCase {
  func test() {
    var viewModel = ViewModel()
    let indexPath = IndexPath(item: 2, section: 0)
    
    XCTAssertThrowsError( try viewModel.getRowCount() ) { error in
      switch error {
      case ModelNotAssignedError.getAccessor:
        return
      default:
        XCTFail()
      }
    }
    
    viewModel.set( getInts: { [0, 1, 2, 3] } )
    
    XCTAssertThrowsError(
      try viewModel.handleSelection(indexPath: indexPath)
    ) { error in
      switch error {
      case ModelNotAssignedError.method:
        return
      default:
        XCTFail()
      }
    }
    
    XCTAssertThrowsError( try viewModel.doSomething() ) { error in
      switch error {
      case ModelNotAssignedError.method:
        return
      default:
        XCTFail()
      }
    }
  }
}

private struct ViewModel {
  private var getInts: Get<[Int]>
  private var handleSelection: (Int) throws -> Void
  
  var doSomething: () throws -> Void
  
  init() {
    getInts = ModelNotAssignedError.makeGetAccessor()
    handleSelection = ModelNotAssignedError.makeMethod()
    doSomething = ModelNotAssignedError.makeMethod()
  }
  
  mutating func set(getInts: @escaping Get<[Int]>) {
    self.getInts = getInts
  }
  
  mutating func set(handleSelection: @escaping (Int) -> Void) {
    self.handleSelection = handleSelection
  }
  
  func getRowCount() throws -> Int {
    let ints = try getInts()
    return ints.count
  }
  
  func name(at indexPath: IndexPath) throws -> String {
    let int = try getElement(indexPath: indexPath, getArray: getInts)
    return String(int)
  }
  
  func handleSelection(indexPath: IndexPath) throws {
    let int = try getElement(indexPath: indexPath, getArray: getInts)
    try handleSelection(int)
  }
}

