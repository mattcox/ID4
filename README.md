# ID4

Welcome to **ID4**, a Swift package describing a 32-bit type identifier, similar to `OSType` or `FourCC`.

## Usage

The ID4 type encodes four ASCII values, and is often used for identifying types in file IO.

For example, to convert the valus "TEST" into an ID4, the type can be created from a string:
```swift
let id4 = ID4("TEST")  // 1413829460
```

The ID4 can then be converted back into ASCII values for simple debugging:
```swift
let id4 = ID4("TEST")  // 1413829460

let a = id4.a  // "T"
let b = id4.b  // "E"
let c = id4.c  // "S"
let d = id4.d  // "T"
```

As the string could contain non-ASCII types such as unicode characters, the initializer returns an optional ID4. A macro is provided that provides compile time checking of the string to ensure it can be used to create an ID4:
```swift
#ID4("TEST")  // Success
#ID4("😢")  // Error
```

## Installation

ID4 is distributed using the [Swift Package Manager](https://swift.org/package-manager). To install it within another Swift package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    // . . .
    dependencies: [
        .package(url: "https://github.com/mattcox/ID4.git", branch: "main")
    ],
    // . . .
)
```

If you’d like to use Pack within an application on Apple platforms, then use Xcode’s `File > Add Packages...` menu command to add it to your project.

Import Pack wherever you’d like to use it:
```swift
import ID4
```
