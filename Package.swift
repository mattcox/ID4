// swift-tools-version: 5.9

import PackageDescription
import CompilerPluginSupport

let package = Package(
	name: "ID4",
	platforms: [
		.macOS(.v11),
		.iOS(.v14),
		.tvOS(.v14),
		.watchOS(.v7),
		.macCatalyst(.v14),
		.visionOS(.v1)
	],
	products: [
		.library(
			name: "ID4",
			targets: [
				"ID4"
			]
		),
	],
	dependencies: [
		.package(
			url: "https://github.com/apple/swift-syntax.git",
			from: "509.0.0"
		),
	],
	targets: [
		.macro(
			name: "ID4Macros",
			dependencies: [
				.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
				.product(name: "SwiftCompilerPlugin", package: "swift-syntax")
			]
		),

		.target(
			name: "ID4",
			dependencies: [
				"ID4Macros"
			]
		),
		.testTarget(
			name: "ID4Tests",
			dependencies: [
				"ID4",
				"ID4Macros",
				.product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
			]
		),
	]
)
