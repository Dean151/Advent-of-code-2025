//
//  Day02.swift
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
struct Day02: Puzzle {
    typealias Input = [ProductIdRange]
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int

    static var componentsSeparator: InputSeparator {
        .string(string: ",")
    }
}

struct ProductIdRange: Parsable, CustomStringConvertible {
    let range: ClosedRange<Int>

    static func parse(raw: String) throws -> Self {
        let parts = raw.components(separatedBy: "-")
        if parts.count != 2 {
            throw InputError.unexpectedInput(unrecognized: raw)
        }
        guard let lowest = Int(parts[0]), let highest = Int(parts[1]) else {
            throw InputError.unexpectedInput(unrecognized: raw)
        }
        return .init(range: lowest...highest)
    }

    var description: String {
        return "\(range.lowerBound)-\(range.upperBound)"
    }

    func twoPartsInvalidIds() -> Set<Int> {
        let lowest = range.lowerBound.description
        let highest = range.upperBound.description
        if lowest.count != highest.count {
            // Split the range, and agglomerate
            let limit = Int(pow(Double(10), Double(lowest.count)))
            let first = ProductIdRange(range: range.lowerBound...limit-1).twoPartsInvalidIds()
            let second = ProductIdRange(range: limit...range.upperBound).twoPartsInvalidIds()
            return first.union(second)
        }
        if lowest.count == 1 || lowest.count % 2 == 1 {
            // No invalid ID for asymetric stuff
            return []
        }
        // Take half the lowest, half the highest
        return invalidIdsOfParts(ofSize: lowest.count / 2)
    }

    func anyPartsInvalidIds() -> Set<Int> {
        let lowest = range.lowerBound.description
        let highest = range.upperBound.description
        if lowest.count != highest.count {
            // Split the range, and agglomerate
            let limit = Int(pow(Double(10), Double(lowest.count)))
            let first = ProductIdRange(range: range.lowerBound...limit-1).anyPartsInvalidIds()
            let second = ProductIdRange(range: limit...range.upperBound).anyPartsInvalidIds()
            return first.union(second)
        }
        if lowest.count == 1 {
            return []
        }
        var invalidIds: Set<Int> = []
        for size in 1...lowest.count/2 {
            invalidIds.formUnion(invalidIdsOfParts(ofSize: size))
        }
        return invalidIds
    }

    func invalidIdsOfParts(ofSize size: Int) -> Set<Int> {
        let lowest = range.lowerBound.description
        let highest = range.upperBound.description
        precondition(lowest.count == highest.count)

        var invalidIds: Set<Int> = []
        let lowestPotential = Int("\(lowest[lowest.startIndex..<lowest.index(after: lowest.index(lowest.startIndex, offsetBy: size-1))])").unsafelyUnwrapped
        let highestPotential = Int("\(highest[highest.startIndex..<highest.index(after: highest.index(highest.startIndex, offsetBy: size-1))])").unsafelyUnwrapped
        for potential in lowestPotential...highestPotential {
            let invalidId = Int(String(repeating: "\(potential)", count: lowest.count / size)).unsafelyUnwrapped
            if range.contains(invalidId) {
                invalidIds.insert(invalidId)
            }
        }
        return invalidIds
    }
}

let example = """
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
"""

// MARK: - PART 1

extension Day02 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 1227775554, fromRaw: example)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        return input.reduce(Set<Int>(), { $0.union($1.twoPartsInvalidIds()) }).reduce(0, +)
    }
}

// MARK: - PART 2
// 29940924880 too low

extension Day02 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 4174379265, fromRaw: example)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        return input.reduce(Set<Int>(), { $0.union($1.anyPartsInvalidIds()) }).reduce(0, +)
    }
}
