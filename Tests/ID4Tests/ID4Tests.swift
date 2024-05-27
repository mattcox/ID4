//
//  ID4Tests.swift
//  ID4Tests
//
//  Created by Matt Cox on 27/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import ID4
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class ID4Tests: XCTestCase {
/// Tests the `a` getter on the ID4.
///
/// This is expected to return the first ASCII value in the ID4.
///
	func testID4_aGetter() throws {
		XCTAssertEqual(#ID4("ABCD").a, "A")
	}
	
/// Tests the `b` getter on the ID4.
///
/// This is expected to return the second ASCII value in the ID4.
///
	func testID4_bGetter() throws {
		XCTAssertEqual(#ID4("ABCD").b, "B")
	}
   
/// Tests the `c` getter on the ID4.
///
/// This is expected to return the third ASCII value in the ID4.
///
	func testID4_cGetter() throws {
		XCTAssertEqual(#ID4("ABCD").c, "C")
	}
	
/// Tests the `d` getter on the ID4.
///
/// This is expected to return the fourth ASCII value in the ID4.
///
	func testID4_dGetter() throws {
		XCTAssertEqual(#ID4("ABCD").d, "D")
	}
	
/// Test the `init(value:)` initializer.
///
	func testID4_valueInit() throws {
		XCTAssertEqual(ID4(1413829460), #ID4("TEST"))
	}
	
/// Test the `init(a:, b:, c:, d:)` initializer.
///
	func testID4_CharacterInit() throws {
		XCTAssertEqual(ID4(a: 84, b: 69, c: 83, d: 84), #ID4("TEST"))
	}
	
/// Test the `init(string:)` initializer.
///
/// The emojis in the string should be ignored.
///
	func testID4_StringInit1() throws {
		XCTAssertEqual(ID4("🔴T🟢E🔵S🟠T"), #ID4("TEST"))
	}
	
/// Test the `init(string:)` initializer.
///
/// The ID4 should only use the first four characters
///
	func testID4_StringInit2() throws {
		XCTAssertEqual(ID4("TESTING THIS LONG STRING"), #ID4("TEST"))
	}
	
/// Test the `init(string:)` initializer.
///
/// The ID4 should be empty.
///
	func testID4_StringInit3() throws {
		XCTAssertEqual(ID4("🔴🟢🔵🟠"), #ID4("    "))
	}
	
/// Test the `init(_ characters: ...)` initializer.
///
	func testID4_VariadicCharacterInit1() throws {
		XCTAssertEqual(ID4("T", "E", "S", "T"), #ID4("TEST"))
	}
	
/// Test the `init(_ characters: ...)` initializer.
///
/// This should fail as only three values are provided.
///
	func testID4_VariadicCharacterInit2() throws {
		XCTAssertNil(ID4("T", "E", "S"))
	}
	
/// Test the `init(_ characters: ...)` initializer.
///
/// This should fail as unicode characters are used.
///
	func testID4_VariadicCharacterInit3() throws {
		XCTAssertNil(ID4("T", "E", "🐍", "T"))
	}
	
/// Test the `init(a:, b:, c:, d:)` character initializer.
///
	func testID4_CharacterInit1() throws {
		XCTAssertEqual(ID4(a: "T", b: "E", c: "S", d: "T"), #ID4("TEST"))
	}

/// Test the `init(a:, b:, c:, d:)` character initializer.
///
/// This should fail as unicode characters are used.
///
	func testID4_CharacterInit2() throws {
		XCTAssertNil(ID4(a: "T", b: "E", c: "🐍", d: "T"))
	}
	
/// Test the `init(values:)` character tuple initializer.
///
	func testID4_CharacterTupleInit1() throws {
		XCTAssertEqual(ID4(("T", "E", "S", "T")), #ID4("TEST"))
	}

/// Test the `init(values:)` character tuple initializer.
///
/// This should fail as unicode characters are used.
///
	func testID4_CharacterTupleInit2() throws {
		XCTAssertNil(ID4(("T", "E", "🐍", "T")))
	}
}
