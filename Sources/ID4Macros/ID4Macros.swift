//
//  ID4Macros.swift
//  ID4Macros
//
//  Created by Matt Cox on 27/05/2024.
//  Copyright © 2023 Matt Cox. All rights reserved.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Declare the macros implemented by this package.
///
@main
struct Plugin: CompilerPlugin {
	let providingMacros: [Macro.Type] = [
		ID4Macro.self,
	]
}
