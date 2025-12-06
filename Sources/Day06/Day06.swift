//
//  Day06.swift
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
struct Day06: Puzzle {
    typealias Input = String
    typealias OutputPartOne = Int
    typealias OutputPartTwo = Int
}

struct Worksheet {
    let problems: [Problem]

    static func parsePart1(raw: String) throws -> Worksheet {
        let lines = raw.components(separatedBy: .newlines)
        let numberOfProblems = lines.first!.components(separatedBy: .whitespaces).filter({ !$0.isEmpty }).count
        var numbers: [[Int]] = .init(repeating: [], count: numberOfProblems)
        var problems: [Problem] = []
        for line in lines {
            let components = line.components(separatedBy: .whitespaces).filter { !$0.isEmpty }
            assert(components.count == numberOfProblems)
            for (index,component) in components.enumerated() {
                if let number = Int(component) {
                    numbers[index].append(number)
                } else {
                    switch component {
                    case "+": problems.append(.add(numbers[index]))
                    case "*": problems.append(.multiply(numbers[index]))
                    default: throw InputError.unexpectedInput(unrecognized: component)
                    }
                }
            }
        }
        return .init(problems: problems)
    }

    static func parsePart2(raw: String) throws -> Worksheet {
        var lines = raw.components(separatedBy: .newlines)
        // remove the last line that correspond to the operations
        let operations = lines.removeLast().components(separatedBy: .whitespaces).filter { !$0.isEmpty }
        // Now we have to read the numbers by columns
        var problemIndex = 0
        var numbers: [[Int]] = .init(repeating: [], count: operations.count)
        for (column, _) in lines.first!.enumerated() {
            let string = String(
                lines.compactMap({ column < $0.count ? $0[$0.index($0.startIndex, offsetBy: column)] : nil })
            ).trimmingCharacters(in: .whitespaces)
            if string.isEmpty {
                // New problem
                problemIndex += 1
                continue
            }
            // Construct the number using all the lines
            guard let number = Int(string) else {
                throw InputError.unexpectedInput(unrecognized: raw)
            }
            numbers[problemIndex].append(number)
        }
        var problems: [Problem] = []
        for (operation, numbers) in zip(operations, numbers) {
            switch operation {
            case "+": problems.append(.add(numbers))
            case "*": problems.append(.multiply(numbers))
            default: throw InputError.unexpectedInput(unrecognized: operation)
            }
        }
        return .init(problems: problems)
    }

    var sum: Int {
        problems.map(\.solution).reduce(0, +)
    }
}

enum Problem {
    case add([Int])
    case multiply([Int])

    var solution: Int {
        switch self {
        case .add(let numbers): numbers.reduce(0, +)
        case .multiply(let numbers): numbers.reduce(1, *)
        }
    }
}

let example = """
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +
"""

// MARK: - PART 1

extension Day06 {
    static var partOneExpectations: [any Expectation<Input, OutputPartOne>] {
        [
            assert(expectation: 4277556, fromRaw: example)
        ]
    }

    static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
        try Worksheet.parsePart1(raw: input).sum
    }
}

// MARK: - PART 2

extension Day06 {
    static var partTwoExpectations: [any Expectation<Input, OutputPartTwo>] {
        [
            assert(expectation: 3263827, fromRaw: example)
        ]
    }

    static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
        try Worksheet.parsePart2(raw: input).sum
    }
}
