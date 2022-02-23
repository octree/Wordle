//
//  Guess.swift
//  Wordle
//
//  Created by octree on 2022/2/22.
//
//  Copyright (c) 2022 Octree <octree@octree.me>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import SwiftUI

public enum LetterGuessResult: Equatable {
    case correct
    case misplaced
    case wrong
}

public struct Guess {
    public let index: Int
    public var guessLetters: [Character]
    public var isFlipped: [Bool]
}

public extension Guess {
    subscript(_ index: Int) -> Character {
        index < guessLetters.count ? guessLetters[index] : " "
    }

    var word: String { String(guessLetters) }

    mutating func deleteBackward() {
        guard guessLetters.count > 0 else { return }
        guessLetters.removeLast()
    }

    mutating func insert(character: Character) {
        guard guessLetters.count < isFlipped.count else { return }
        guessLetters.append(character)
    }
}

extension Guess: Identifiable {
    public var id: Int { index }
}

extension Guess: Codable {
    enum CodingKeys: String, CodingKey {
        case index
        case guessLetters
        case isFlipped
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.index = try container.decode(Int.self, forKey: .index)
        self.guessLetters = try container.decode([String].self, forKey: .guessLetters)
            .map { $0.first! }
        self.isFlipped = try container.decode([Bool].self, forKey: .isFlipped)
    }

    public func encode(to encoder: Encoder) throws {
        var conatiner = encoder.container(keyedBy: CodingKeys.self)
        try conatiner.encode(index, forKey: .index)
        try conatiner.encode(guessLetters.map { String($0) }, forKey: .guessLetters)
        try conatiner.encode(isFlipped, forKey: .isFlipped)
    }
}
