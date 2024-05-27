//
//  ID4MacroTests.swift
//  ID4Tests
//
//  Created by Matt Cox on 27/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(ID4Macros)
import ID4
import ID4Macros

let macros: [String: Macro.Type] = [
	"ID4": ID4Macro.self,
]
#endif

final class ID4MacroTests: XCTestCase {
/// Tests a simple string can be converted into an ID4.
///
	func testID4MacroFromStringValidString() throws {
#if canImport(ID4Macros)
		assertMacroExpansion(
			"#ID4('TEST')",
			expandedSource: "ID4(a: 84, b: 69, c: 83, d: 84)",
			macros: macros
		)
#else
		throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
	}
	
/// Tests a long string can be converted into an ID4.
///
/// Only the first four characters should be used.
///
	func testID4MacroFromLongString() throws {
#if canImport(ID4Macros)
		assertMacroExpansion(
			"#ID4('TEST THIS REALLY LONG STRING')",
			expandedSource: "ID4(a: 84, b: 69, c: 83, d: 84)",
			macros: macros
		)
#else
		throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
	}
	
/// Tests a string with an invalid character can be converted into an ID4.
///
/// Only the first four characters should be used.
///
	func testID4MacroFromStringWithIllegalCharacters() throws {
#if canImport(ID4Macros)
		assertMacroExpansion(
			"#ID4('TEST 🤕')",
			expandedSource: "ID4(a: 84, b: 69, c: 83, d: 84)",
			macros: macros
		)
#else
		throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
	}
	
/// Tests an empty string can be converted into an ID4.
///
/// The ID4 should contain only spaces.
///
	func testID4MacroFromEmptyString() throws {
#if canImport(ID4Macros)
		assertMacroExpansion(
			"#ID4('')",
			expandedSource: "ID4(a: 32, b: 32, c: 32, d: 32)",
			macros: macros
		)
#else
		throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
	}
}
