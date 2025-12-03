//
//  Day03.swift
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
struct Day03: Puzzle {
    typealias Input = [BatteryBank]
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

struct BatteryBank: Parsable, CustomStringConvertible {
    let joltages: [Int]

    static func parse(raw: String) throws -> BatteryBank {
        .init(joltages: raw.map { Int("\($0)").unsafelyUnwrapped })
    }

    var description: String {
        joltages.map(String.init).joined()
    }

    func highestJoltage(with count: Int) -> Int {
        var digits: [Int] = []
        var position = 0
        repeat {
            let slice = joltages[position..<joltages.count-(count-(digits.count+1))]
            let digit = slice.max().unsafelyUnwrapped
            position = slice.firstIndex(of: digit).unsafelyUnwrapped + 1
            digits.append(digit)
        } while digits.count < count
        return Int(digits.reduce("", { $0 + "\($1)" })).unsafelyUnwrapped
    }
}

let example = """
987654321111111
811111111111119
234234234234278
818181911112111
"""

// 234234234234278
//   4 34444444478 found
//   4 34234234278 expected

// MARK: - PART 1

extension Day03 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 98, fromRaw: "987654321111111"),
            assert(expectation: 89, fromRaw: "811111111111119"),
            assert(expectation: 78, fromRaw: "234234234234278"),
            assert(expectation: 92, fromRaw: "818181911112111"),
            assert(expectation: 357, fromRaw: example)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        input.map{ $0.highestJoltage(with: 2) }.reduce(0, +)
    }
}

// MARK: - PART 2

extension Day03 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 987654321111, fromRaw: "987654321111111"),
            assert(expectation: 811111111119, fromRaw: "811111111111119"),
            assert(expectation: 434234234278, fromRaw: "234234234234278"),
            assert(expectation: 888911112111, fromRaw: "818181911112111"),
            assert(expectation: 3121910778619, fromRaw: example)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        input.map{ $0.highestJoltage(with: 12) }.reduce(0, +)
    }
}
