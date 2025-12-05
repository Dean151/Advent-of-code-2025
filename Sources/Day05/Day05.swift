//
//  Day05.swift
//  AoC-Swift-Template
//  Forked from https://github.com/Dean151/AoC-Swift-Template
//
//  Created by Thomas DURAND.
//  Follow me on Twitter @deanatoire
//  Check my computing blog on https://www.thomasdurand.fr/
//

import Algorithms
import Foundation

import AoC
import Common

@main
struct Day05: Puzzle {
    typealias Input = Ingredients
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

let example = """
3-5
10-14
16-20
12-18

1
5
8
11
17
32
"""

struct Ingredients: Parsable {
    let freshRanges: [ClosedRange<Int>]
    let ingredients: [Int]

    static func parse(raw: String) throws -> Ingredients {
        let parts = raw.components(separatedBy: "\n\n")
        assert(parts.count == 2)
        let freshRanges: [ClosedRange<Int>] = try parts[0].components(separatedBy: .newlines).map(ClosedRange.parse(raw:))
        let ingredients: [Int] = try parts[1].components(separatedBy: .newlines).map(Int.parse(raw:))
        return .init(freshRanges: freshRanges, ingredients: ingredients)
    }

    var freshIngredients: [Int] {
        ingredients.filter { ingredient in
            freshRanges.contains { range in
                range.contains(ingredient)
            }
        }
    }

    var uniqueFreshIngredientsCount: Int {
        // Sort ranges
        let sortedRanges = freshRanges.sorted {
            return if $0.lowerBound == $1.lowerBound {
                $0.upperBound < $1.upperBound
            } else {
                $0.lowerBound < $1.lowerBound
            }
        }
        // Make sure each range do not overlap with the previous one.
        // If so, clamp it, or remove it entirely
        var clampedRanges: [ClosedRange<Int>] = [sortedRanges[0]]
        for ranges in sortedRanges.windows(ofCount: 2) {
            assert(ranges.count == 2)
            let previous = ranges.first.unsafelyUnwrapped
            let current = ranges.last.unsafelyUnwrapped
            if !previous.contains(current.lowerBound) {
                // Disjoint, just add it as is
                clampedRanges.append(current)
                continue
            }
            if previous.contains(current.upperBound) {
                // Entirely included. We can skip it
                continue
            }
            // Make a new one, disjoint
            clampedRanges.append((previous.upperBound+1)...current.upperBound)
        }
        // Now that there is no overlap, just add the counts
        return clampedRanges.reduce(0) { $0 + $1.count }
    }
}

extension ClosedRange<Int>: Parsable {
    public static func parse(raw: String) throws -> ClosedRange<Int> {
        let parts = raw.components(separatedBy: "-")
        assert(parts.count == 2)
        guard let lower = Int(parts[0]), let upper = Int(parts[1]) else {
            throw InputError.unexpectedInput(unrecognized: raw)
        }
        return .init(uncheckedBounds: (lower, upper))
    }
}

// MARK: - PART 1

extension Day05 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 3, fromRaw: example)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        input.freshIngredients.count
    }
}

// MARK: - PART 2

extension Day05 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 14, fromRaw: example)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        input.uniqueFreshIngredientsCount
    }
}
