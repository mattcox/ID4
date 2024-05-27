//
//  ID4Macro.swift
//  ID4Macros
//
//  Created by Matt Cox on 27/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// A macro that converts the first four characters in a string into an ID4
/// value.
///
/// The first four characters must be ASCII values, or the macro will fail.
///
public struct ID4Macro: ExpressionMacro {
	public static func expansion(of node: some FreestandingMacroExpansionSyntax, in context: some MacroExpansionContext) throws -> ExprSyntax {
		guard let argument = node.argumentList.first?.expression,
			  let segments = argument.as(StringLiteralExprSyntax.self)?.segments,
			  segments.count == 1,
			  case .stringSegment(let literalSegment)? = segments.first
		else {
			throw MacroError.failed("#ID4 requires a static string literal.")
		}
		
		// Attempt to convert the characters to ascii values.
		//
		let asciiCharacters = try literalSegment.content.text
			.prefix(4)
			.map {
				guard let ascii = $0.asciiValue else {
					throw MacroError.invalidArgument(parameter: "stringLiteral", reason: "\($0) is not a valid ASCII character.")
				}
			
				return ascii
			}

		// Pad the characters to four ascii values.
		//
		let values: (a: UInt8, b: UInt8, c: UInt8, d: UInt8) = try {
			if asciiCharacters.count >= 4 {
				return (a: asciiCharacters[0], b: asciiCharacters[1], c: asciiCharacters[2], d: asciiCharacters[3])
			}
			
			guard let spaceAscii = Character(" ").asciiValue else {
				throw MacroError.failed("Something went wrong")
			}
			
			let asciiCharactersPadded = asciiCharacters + Array(repeating: spaceAscii, count: max(4 - asciiCharacters.count, 0))
			return (a: asciiCharactersPadded[0], b: asciiCharactersPadded[1], c: asciiCharactersPadded[2], d: asciiCharactersPadded[3])
		}()
		
		return ExprSyntax(stringLiteral: String("ID4(a: \(values.a), b: \(values.b), c: \(values.c), d: \(values.d))"))
	}
}
