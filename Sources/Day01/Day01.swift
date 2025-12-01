//
//  Day01.swift
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
struct Day01: Puzzle {
    typealias Input = [Rotation]
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

enum Rotation: Parsable, CustomStringConvertible {
    case left(amount: Int)
    case right(amount: Int)

    static func parse(raw: String) throws -> Rotation {
        let rawDirection = raw[raw.startIndex]
        let rawAmount = raw[raw.index(after: raw.startIndex)...]
        guard let amount = Int(rawAmount) else {
            throw InputError.unexpectedInput(unrecognized: raw)
        }
        return switch rawDirection {
        case "L": .left(amount: amount)
        case "R": .right(amount: amount)
        default: throw InputError.unexpectedInput(unrecognized: raw)
        }
    }

    var description: String {
        switch self {
        case .left(let amount): "L\(amount)"
        case .right(let amount): "R\(amount)"
        }
    }
}

let example = """
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"""

// MARK: - PART 1

extension Day01 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 3, fromRaw: example)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        var position = 50
        var count = 0
        for instruction in input {
            switch instruction {
            case .left(let amount):
                position -= amount
            case .right(let amount):
                position += amount
            }
            position %= 100
            if position < 0 {
                position += 100
            }
            if position == 0 {
                count += 1
            }
        }
        return count
    }
}

// MARK: - PART 2
// 6225 too low
// 6229 too low

extension Day01 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 6, fromRaw: example)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        var position = 50
        var count = 0
        for instruction in input {
            var increment = position > 0
            switch instruction {
            case .left(let amount):
                position -= amount
            case .right(let amount):
                position += amount
            }
            while position < 0 {
                position += 100
                if increment {
                    count += 1
                } else {
                    increment = true
                }
            }
            var check = true
            while position >= 100 {
                position -= 100
                count += 1
                check = false
            }
            if check && position == 0 {
                count += 1
            }
        }
        return count
    }
}
