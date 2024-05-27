//
//  MacroError.swift
//  ID4Macros
//
//  Created by Matt Cox on 27/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import Foundation

/// A set of common macro related errors.
///
public enum MacroError: Error {
/// A generic error, used to indicate that _something_ has failed.
///
/// This is intended as a general failure, used to handle cases where a more
/// descriptive error code is insufficient.
///
/// A reason for the failure can optionally be provided.
///
/// This example demonstrates how to use the `failed` error.
/// ```swift
/// func someThrowingFunction() throws {
///     throw MacroError.failed("This failed for some reason")
/// }
/// ```
///
/// - Parameters:
///   - reason: The reason for the failure.
///
/// The error conforms to `CustomDebugStringConvertible`, so can be printed
/// to the console for debugging.
/// ```swift
/// print(MacroError.failed("This failed for some reason"))
/// // Prints "Failed: "This failed for some reason""
/// ```
///
/// - Note: This error should be avoided wherever possible, and instead a
/// more descriptive code should be used.
///
	case failed(_ reason: String? = nil)

/// An error used to indicate that an argument or arguments passed to a
/// macro is invalid.
///
/// The parameter should be provided, and a reason for the failure can
/// optionally be provided.
///
/// - Parameters:
///   - parameter: The name of the parameter that was invalid.
///   - reason: The reason for the failure.
///
/// The error conforms to `CustomDebugStringConvertible`, so can be printed
/// to the console for debugging.
/// ```swift
/// print(MacroError.invalidArgument(parameter: "myInteger", reason: "The value cannot be zero"))
/// // Prints "Invalid Argument (myInteger): "The value cannot be zero""
/// ```
///
	case invalidArgument(parameter: String, reason: String? = nil)
}

extension MacroError: CustomStringConvertible {
/// A textual representation of the Error.
///
	public var description: String {
		self.debugDescription
	}
}

extension MacroError: CustomDebugStringConvertible {
/// A textual representation of the Error.
///
	public var debugDescription: String {
		get {
			switch self {
				case .failed(let reason):
					if let reason = reason {
						return "Failed: \"\(reason)\"."
					}
					else {
						return "Failed."
					}
				case .invalidArgument(let parameter, let reason):
					if let reason = reason {
						return "Invalid Argument (\(parameter)): \"\(reason)\"."
					}
					else {
						return "Invalid Argument (\(parameter))."
					}
			}
		}
	}
}
