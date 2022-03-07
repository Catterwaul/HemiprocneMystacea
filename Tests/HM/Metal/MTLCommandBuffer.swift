import HM
import XCTest

final class MTLCommandBufferTestCase: XCTestCase {
  func test() async {
    let buffer = MTLCreateSystemDefaultDevice()!.makeCommandQueue()!.makeCommandBuffer()!
    await buffer.complete()

    let string: String = await withTaskGroup(of: String.self) { group in
      let buffer = MTLCreateSystemDefaultDevice()!.makeCommandQueue()!.makeCommandBuffer()!

      group.addTask {
        await buffer.schedulingCompletion
        return "2"
      }

      group.addTask {
        await buffer.completion
        return "3"
      }

      group.addTask {
        buffer.commit()
        return "1"
      }

      return await .init(group)
    }

    XCTAssertEqual(string, "123")
  }
}
