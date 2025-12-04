//
//  Day04.swift
//  AoC-Swift-Template
//  Forked from https://github.com/Dean151/AoC-Swift-Template
//
//  Created by Thomas DURAND.
//  Follow me on Twitter @deanatoire
//  Check my computing blog on https://www.thomasdurand.fr/
//

import Foundation

import AoC
import Common

@main
struct Day04: Puzzle {
    typealias Input = Warehouse
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

let example = """
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

struct Warehouse: Parsable {
    let rollsPositions: Set<Coordinates>

    static func parse(raw: String) throws -> Warehouse {
        var positions = Set<Coordinates>()
        for (y,line) in raw.components(separatedBy: .newlines).enumerated() {
            for (x,char) in line.enumerated() {
                if char == "@" {
                    positions.insert(.init(x: x, y: y))
                }
            }
        }
        return .init(rollsPositions: positions)
    }

    var accessibleRolls: Set<Coordinates> {
        rollsPositions.filter {
            $0.allNeighbors.filter(rollsPositions.contains).count < 4
        }
    }

    func removing(rolls: Set<Coordinates>) -> Self {
        .init(rollsPositions: rollsPositions.subtracting(rolls))
    }
}

// MARK: - PART 1

extension Day04 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 13, fromRaw: example)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        return input.accessibleRolls.count
    }
}

// MARK: - PART 2

extension Day04 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 43, fromRaw: example)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        var count = 0
        var warehouse = input
        var accessibleRolls: Set<Coordinates>
        repeat {
            accessibleRolls = warehouse.accessibleRolls
            count += accessibleRolls.count
            warehouse = warehouse.removing(rolls: accessibleRolls)
        } while !accessibleRolls.isEmpty
        return count
    }
}
