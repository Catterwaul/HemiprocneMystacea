import HM
import XCTest

final class DictionaryTestCase: XCTestCase {
//MARK:- Operators
  func test_minus() {
    let dictionary = [
      1: 10,
      2: 20,
      3: 30
    ]
    XCTAssertEqual(
      dictionary - [1, 3],
      [2: 20]
    )
  }

  func test_minusEquals() {
    var dictionary = [
      1: 10,
      2: 20,
      3: 30
    ]
    dictionary -= [
      2: "🏩",
      1: "🤘🏽"
    ].keys
    XCTAssertEqual(
      dictionary,
      [3: 30]
    )
  }
  
//MARK:- Initializers
  func test_init_grouping_KeyValuePairs() {
    let dictionary = [
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
      Dictionary(
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
      Dictionary(
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

//MARK:- Subscripts
  func test_optionalKeySubscript() {
    let dictionary = ["key": "value"]
    let key: String? = "key"
    let `nil`: String? = nil

    XCTAssertEqual(dictionary[key], "value")
    XCTAssertEqual(dictionary[`nil`], nil)
  }

  func test_valueAddedIfNilSubscript() {
    var dictionary = ["key": "value"]
    let valyoo = "valyoo"
    XCTAssertEqual(
      dictionary[
        "kee",
        valueAddedIfNil: valyoo
      ],
      valyoo
    )
    XCTAssertEqual(
      dictionary,
      [  "key": "value",
        "kee": "valyoo"
      ]
    )
  }

//MARK:- Methods
  func test_mapValues() {
    XCTAssertEqual(
      [ "🍍": "🥐",
        "🥝": "🥯"
      ].mapToValues { tropicalFruit, _ in tropicalFruit },
      [ "🍍": "🍍",
        "🥝": "🥝"
      ]
    )
  }
}
