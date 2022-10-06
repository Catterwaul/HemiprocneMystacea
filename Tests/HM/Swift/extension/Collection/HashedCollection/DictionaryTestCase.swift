import HM
import XCTest

final class DictionaryTestCase: XCTestCase {
  func test_PickValue() {
    let original = ["🗝": "🏰"]
    let overwriting = ["🗝": "✍️"]

    XCTAssertEqual(
      original.merging(overwriting, uniquingKeysWith: PickValue.keep),
      original
    )

    XCTAssertEqual(
      original.merging(overwriting, uniquingKeysWith: PickValue.overwrite),
      overwriting
    )
  }
  
  // MARK: - Initializers
  
  func test_init_uniqueKeysWithValues_KeyValuePairs() {
    XCTAssertEqual(
      Dictionary(
        uniqueKeysWithValues: ["🍐": "🪂", "👯‍♀️": "👯‍♂️"] as KeyValuePairs
      ),
      .init(
        uniqueKeysWithValues: [("🍐", "🪂"), ("👯‍♀️", "👯‍♂️")]
      )
    )
  }

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

  func test_init_bucketing() {
    XCTAssertEqual(
      Dictionary(bucketing: "🗑⚱️🗑🦌🦌🗑🗑🦌⚱️"),
      ["⚱️" as Character: 2, "🗑": 4, "🦌": 3]
    )
  }

// MARK: - Subscripts
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
      [ "key": "value",
        "kee": "valyoo"
      ]
    )
  }

  func test_firstKeys() {
    XCTAssertEqual(
      try ["skunky": "monkey", "🦨": "🐒"].onlyKey(for: "🐒"),
      "🦨"
    )
  }

// MARK: - Methods
  func test_flatMap() {
    XCTAssert(
      [ "red": ["🍷", "💄"],
        "green": ["🤢"],
        "blue": ["🥏", "👮‍♀️", "👮‍♀️"]
      ].flatMap().sorted { $0.key }
      .elementsEqual(
        [ "blue": "🥏", "blue": "👮‍♀️", "blue": "👮‍♀️",
          "green": "🤢",
          "red": "🍷", "red": "💄",
        ] as KeyValuePairs,
        by: ==
      )
    )
  }

  func test_mapKeys() {
    let dictionary = [100: "💯", 17: "📅"]
    XCTAssertEqual(
      dictionary.mapKeys(String.init),
      ["100": "💯", "17": "📅"]
    )
    XCTAssertEqual(
      dictionary.compactMapKeys { $0 > 50 ? $0 : nil },
      [100: "💯"]
    )

    XCTAssertEqual(
      ["🐯": 1, "🦁": 2].mapKeys( { _ in "😺" }, uniquingKeysWith: + ),
      ["😺": 3]
    )
  }

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

  func test_merge() {
    var dictionary = ["👁": "👀"]
    dictionary.merge(["🍩"].keyed { $0 }, uniquingKeysWith: PickValue.keep)
    XCTAssertEqual(dictionary, ["👁": "👀", "🍩": "🍩"])
  }
}
