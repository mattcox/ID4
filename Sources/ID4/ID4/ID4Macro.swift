//
//  ID4Macro.swift
//  ID4
//
//  Created by Matt Cox on 27/05/2024.
//  Copyright © 2024 Matt Cox. All rights reserved.
//

import Foundation

/// A macro that converts the first four characters in a string into an ID4
/// value.
///
/// The first four characters must be ASCII values, or the macro will fail.
///
@freestanding(expression)
public macro ID4(_ stringLiteral: String) -> ID4 = #externalMacro(module: "ID4Macros", type: "ID4Macro")
