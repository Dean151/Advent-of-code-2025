// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v26)],
    products: [
        .library(name: "AoC", targets: ["AoC"]),
        .library(name: "Common", targets: ["Common"]),

        .executable(name: "Day01", targets: ["Day01"]),
        .executable(name: "Day02", targets: ["Day02"]),
        .executable(name: "Day03", targets: ["Day03"]),
        .executable(name: "Day04", targets: ["Day04"]),
        .executable(name: "Day05", targets: ["Day05"]),
        .executable(name: "Day06", targets: ["Day06"]),
        .executable(name: "Day07", targets: ["Day07"]),
        .executable(name: "Day08", targets: ["Day08"]),
        .executable(name: "Day09", targets: ["Day09"]),
        .executable(name: "Day10", targets: ["Day10"]),
        .executable(name: "Day11", targets: ["Day11"]),
        .executable(name: "Day12", targets: ["Day12"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-collections", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "2.0.0"),
    ],
    targets: [
        .target(name: "AoC"),
        .target(name: "Common", dependencies: [
            .product(name: "Algorithms", package: "swift-algorithms"),
            .product(name: "Collections", package: "swift-collections"),
            .product(name: "Crypto", package: "swift-crypto"),
        ]),

        .executableTarget(name: "Day01", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day02", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day03", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day04", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day05", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day06", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day07", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day08", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day09", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day10", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day11", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),
        .executableTarget(name: "Day12", dependencies: ["AoC", "Common"], resources: [.process("input.txt")]),

        .testTarget(name: "Day01Tests", dependencies: ["Day01"]),
        .testTarget(name: "Day02Tests", dependencies: ["Day02"]),
        .testTarget(name: "Day03Tests", dependencies: ["Day03"]),
        .testTarget(name: "Day04Tests", dependencies: ["Day04"]),
        .testTarget(name: "Day05Tests", dependencies: ["Day05"]),
        .testTarget(name: "Day06Tests", dependencies: ["Day06"]),
        .testTarget(name: "Day07Tests", dependencies: ["Day07"]),
        .testTarget(name: "Day08Tests", dependencies: ["Day08"]),
        .testTarget(name: "Day09Tests", dependencies: ["Day09"]),
        .testTarget(name: "Day10Tests", dependencies: ["Day10"]),
        .testTarget(name: "Day11Tests", dependencies: ["Day11"]),
        .testTarget(name: "Day12Tests", dependencies: ["Day12"]),
    ],
    swiftLanguageModes: [.v6]
)
