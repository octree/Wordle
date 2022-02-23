//
//  Puzzle.swift
//  Wordle
//
//  Created by octree on 2022/2/23.
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

public struct Puzzle {
    public var word: String {
        didSet {
            letterSet = Set(letters)
        }
    }

    public var letters: [Character] { word.map { $0 } }
    private var letterSet: Set<Character>

    public init(word: String) {
        self.word = word
        self.letterSet = Set(word.map { $0 })
    }

    public func contains(letter: Character) -> Bool {
        letterSet.contains(letter)
    }

    public func guess(_ letter: Character, at index: Int) -> LetterGuessResult {
        guard contains(letter: letter) else { return .wrong }
        let letterIndex = word.index(word.startIndex, offsetBy: index)
        return word[letterIndex] == letter ? .correct : .misplaced
    }
}

extension Puzzle: Codable {
    public init(from decoder: Decoder) throws {
        let single = try decoder.singleValueContainer()
        self.word = try single.decode(String.self)
        self.letterSet = Set(word.map { $0 })
    }

    public func encode(to encoder: Encoder) throws {
        var single = encoder.singleValueContainer()
        try single.encode(word)
    }
}

public extension Puzzle {
    func createEmptyGuess(index: Int) -> Guess {
        Guess(index: index,
              guessLetters: [],
              isFlipped: word.map { _ in false })
    }
}
