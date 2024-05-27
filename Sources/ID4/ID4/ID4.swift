//
//  ID4.swift
//  ID4
//
//  Created by Matt Cox on 27/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import Foundation

/// A 32-bit identifier type.
///
/// This is similar in concept to `OSType` or `FourCC`.
///
/// These types are constructed from four ASCII values to provide a description
/// for their purpose.
///
public struct ID4 {
/// The underlying value for the ID4.
///
	public let value: UInt32

/// The first character used to initialize the ID4.
///
	public var a: Character {
		Character(UnicodeScalar(UInt8((value >> 24) & 0x00FF)))
	}
	
/// The second character used to initialize the ID4.
///
	public var b: Character {
		Character(UnicodeScalar(UInt8((value >> 16) & 0x00FF)))
	}
	
/// The third character used to initialize the ID4.
///
	public var c: Character {
		Character(UnicodeScalar(UInt8((value >> 8) & 0x00FF)))
	}
	
/// The fourth character used to initialize the ID4.
///
	public var d: Character {
		Character(UnicodeScalar(UInt8((value) & 0x00FF)))
	}

/// Initialize the ID4 with a raw value.
///
/// - Parameters:
///   - value: The raw value to store in the ID4.
///
	public init(_ value: UInt32) {
		self.value = value
	}
	
/// Initialize the ID4 with four ASCII values.
///
/// - Parameters:
///   - a: The first ASCII to store in the ID4.
///   - b: The first ASCII to store in the ID4.
///   - c: The first ASCII to store in the ID4.
///   - d: The first ASCII to store in the ID4.
///
	public init(a: UInt8, b: UInt8, c: UInt8, d: UInt8) {
		self.value = UInt32(a) << 24 | UInt32(b) << 16 | UInt32(c) << 8 | UInt32(d)
	}
	
/// Initialize the ID4 from a string.
///
/// The first four ASCII characters in the string will be stored in the ID4.
///
/// - Parameters:
///   - string: The string to convert into an ID4.
///
	public init?(_ string: String) {
		let values = string.compactMap {
			$0.asciiValue
		}
		
		guard let spaceAscii = Character(" ").asciiValue else {
			return nil
		}
			
		let valuesPadded = values + Array(repeating: spaceAscii, count: max(4 - values.count, 0))
		
		guard valuesPadded.count >= 4 else {
			return nil
		}
		
		self = ID4(a: valuesPadded[0], b: valuesPadded[1], c: valuesPadded[2], d: valuesPadded[3])
	}
	
/// Initialize the ID4 from a series of ASCII characters.
///
/// At least four ASCII characters must be provided to initialize the ID4.
///
/// - Parameters:
///   - characters: The characters to store in the ID4.
///
	public init?(_ characters: Character...) {
		guard characters.count >= 4,
			  let id4 = ID4(a: characters[0], b: characters[1], c: characters[2], d: characters[3])
		else {
			return nil
		}
		
		self = id4
	}
	
/// Initialize the ID4 from four ASCII characters.
///
/// The four characters must be ASCII characters.
///
/// - Parameters:
///   - a: The first character to store in the ID4.
///   - b: The second character to store in the ID4.
///   - c: The third character to store in the ID4.
///   - d: The four character to store in the ID4.
///
	public init?(a: Character, b: Character, c: Character, d: Character) {
		guard let asciiA = a.asciiValue,
			  let asciiB = b.asciiValue,
			  let asciiC = c.asciiValue,
			  let asciiD = d.asciiValue
		else {
			return nil
		}
		
		self = ID4(a: asciiA, b: asciiB, c: asciiC, d: asciiD)
	}

/// Initialize the ID4 from a tuple containing ASCII characters.
///
/// The four characters must be ASCII characters.
///
/// - Parameters:
///   - values: The four ASCII characters to store in the ID4.
///
	public init?(_ values: (Character, Character, Character, Character)) {
		guard let id4 = ID4(a: values.0, b: values.1, c: values.2, d: values.3) else {
			return nil
		}
		
		self = id4
	}
}

extension ID4 {
/// The ID4 as an `OSType`.
///
	public var osType: OSType {
		OSType(self.value)
	}
	
/// Initialize from an `OSType`.
///
	public init(osType: OSType) {
		self.value = osType
	}
}

extension ID4: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		self.value = try container.decode(UInt32.self)
	}
	
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(self.value)
	}
}

extension ID4: CustomStringConvertible {
	public var description: String {
		String("\(a), \(b), \(c), \(d)")
	}
}

extension ID4: Equatable {
	
}

extension ID4: ExpressibleByIntegerLiteral {
	public init(integerLiteral value: UInt32) {
		self = ID4(value)
	}
}

extension ID4: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(self.value)
	}
}
