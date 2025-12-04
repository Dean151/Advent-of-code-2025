//
//  Geometry.swift
//  AdventOfCode
//
//  Created by Thomas Durand on 04/12/2025.
//

public struct Coordinates: Hashable, Equatable {
    public let x: Int
    public let y: Int

    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

// Neighbors

extension Coordinates: CustomStringConvertible {
    public var description: String {
        "(\(x),\(y))"
    }
}

extension Coordinates {
    public var adjectiveNeighbors: [Coordinates] {
        [
            .init(x: x - 1, y: y),
            .init(x: x, y: y - 1),
            .init(x: x + 1, y: y),
            .init(x: x, y: y + 1)
        ]
    }

    public var diagonalNeighbors: [Coordinates] {
        [
            .init(x: x - 1, y: y - 1),
            .init(x: x - 1, y: y + 1),
            .init(x: x + 1, y: y - 1),
            .init(x: x + 1, y: y + 1)
        ]
    }

    public var allNeighbors: [Coordinates] {
        adjectiveNeighbors + diagonalNeighbors
    }
}

