import typealias Collections.OrderedDictionary
import HM
import XCTest

final class OrderedDictionaryTestCase: XCTestCase {
  func test_init_grouping_KeyValuePairs() {
    let dictionary: OrderedDictionary = [
      "🔑": [
        "🐅",
        "🐆",
        "🐈"
      ],
      "🗝": [
        "🦖",
        "🦕"
      ]
    ]

    XCTAssertEqual(
      OrderedDictionary(
        grouping: [
          ("🔑", "🐅"),
          ("🔑", "🐆"),
          ("🔑", "🐈"),

          ("🗝", "🦖"),
          ("🗝", "🦕")
        ]
      ),
      dictionary
    )

    XCTAssertEqual(
      OrderedDictionary(
        grouping: [
          "🔑": "🐅",
          "🔑": "🐆",
          "🔑": "🐈",

          "🗝": "🦖",
          "🗝": "🦕"
        ] as KeyValuePairs
      ),
      dictionary
    )
  }
}
