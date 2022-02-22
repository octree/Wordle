import Foundation
import SwiftUI

public enum LetterGuessResult: Equatable {
    case correct
    case misplaced
    case wrong
}

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

public struct Guess {
    public let index: Int
    public var guessLetters: [Character]
    public var isFlipped: [Bool]
}

public extension Puzzle {
    func createEmptyGuess(index: Int) -> Guess {
        Guess(index: index,
              guessLetters: [],
              isFlipped: word.map { _ in false })
    }
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

public enum KeyStatus {
    case used
    case wrong
    case unused
}

public struct GuessStatus {
    public var puzzle: Puzzle
    public var guessed: Set<Character>

    public func status(forKey key: Key) -> KeyStatus {
        guard case let .character(c) = key,
              guessed.contains(c) else { return .unused }
        return puzzle.contains(letter: c) ? .used : .wrong
    }
}
