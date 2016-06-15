import HemiprocneMystacea
import XCTest

final class StringTestCase: XCTestCase {
	func testAfter() {
		XCTAssertEqual(
			"chunky skunky".after("s"),
			"kunky"
		)
		XCTAssertNil(
			"aaabbbccc".after("z")
		)
	}
	
	func testSplit() {
		let string = "boo, gee,rye"
		XCTAssertEqual(
			string.split(by: ","),
			[	"boo",
				" gee",
				"rye"
			]
		)
	}
	
//MARK: upTo
	func testUpTo() {
		XCTAssertEqual(
			"glorb14prawn".upTo("1"),
			"glorb"
		)
	}
	
	func testUpToWithCharacterIncluded() {
		XCTAssertEqual(
			"glorb14prawn".upTo(
				"1",
				characterIsIncluded: true
			),
			"glorb1"
		)
	}
	
	func testUpToWithNonPresentCharacter() {
		XCTAssertNil(
      "boogalawncare".upTo("z")
		)
	}
	
//MARK: Operators
	func testMinus() {
		XCTAssertEqual(
			" 123🐉Boodee Bop! 123🐉" - " 123🐉",
			"Boodee Bop!"
		)
	}

    func testMinusWithSequence() {
        XCTAssertEqual(
            " 123🐉Boodee Bop! 123🐉" - [" 123🐉", "Bo"],
            "odee p!"
        )
    }
	
//MARK: Sequences of Strings
    func testConcatenated() {
        XCTAssertEqual(
            [   "a",
                "bc",
                "d"
            ].concatenated,
            "abcd"
        )
    }
	}
}
