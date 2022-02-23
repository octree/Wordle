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

public struct PersistedPuzzle: Codable {
    public var puzzle: Puzzle
    public var guesses: [Guess]
}

extension PersistedPuzzle {
    private static var url: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("puzzle.json")
    }

    static func read() -> PersistedPuzzle? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(PersistedPuzzle.self, from: data)
    }

    func save() {
        guard let data = try? JSONEncoder().encode(self) else { return }
        try? data.write(to: Self.url)
    }

    static func clear() {
        try? FileManager.default.removeItem(at: url)
    }
}
