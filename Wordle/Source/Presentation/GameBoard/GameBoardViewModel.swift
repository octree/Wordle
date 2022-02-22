import Foundation
import SwiftUI

public enum GameStatus: Hashable, Equatable {
    case won
    case lose
    case playing
}

public enum GameConstants {
    public static let maxAttempCount = 6
}

class GameBoardViewModel: ObservableObject {
    let puzzle: Puzzle
    @Published var status: GameStatus = .playing
    @Published private(set) var appliedGuesses: [Guess] = []
    @Published private(set) var currentGuess: Guess
    @Published private(set) var wrongAttemp: Bool = false
    @Published private(set) var guessStatus: GuessStatus

    var allGuesses: [Guess] {
        status == .playing ? appliedGuesses + [currentGuess] : appliedGuesses
    }

    init(puzzle: Puzzle) {
        self.puzzle = puzzle
        guessStatus = .init(puzzle: puzzle, guessed: [])
        currentGuess = puzzle.createEmptyGuess(index: 0)
    }

    // MARK: - Public Method

    func apply() {
        guard currentGuess.guessLetters.count == puzzle.word.count else {
            performWrongAttempAnimation()
            return
        }
        appliedGuesses.append(currentGuess)
        currentGuess.guessLetters.forEach {
            guessStatus.guessed.insert($0)
        }
        if currentGuess.word == puzzle.word {
            status = .won
        } else if appliedGuesses.count == GameConstants.maxAttempCount {
            status = .lose
        }
        currentGuess = puzzle.createEmptyGuess(index: appliedGuesses.count)
        performFlipAnimation()
    }

    func onTap(key: Key) {
        switch key {
        case .character(let character):
            insert(character: character)
        case .enter:
            apply()
        case .delete:
            deleteBackward()
        }
    }

    // MARK: - Private Methods

    private func insert(character: Character) {
        currentGuess.insert(character: character)
    }

    private func deleteBackward() {
        currentGuess.deleteBackward()
    }

    // MARK: Wrong Attemp Animation

    private func performWrongAttempAnimation() {
        withAnimation(.easeIn(duration: 0.1).repeatCount(5, autoreverses: true)) {
            wrongAttemp = true
        }
        Task {
            try await Task.sleep(nanoseconds: 500_000_000)
            await resetWrongAttemp()
        }
    }

    @MainActor
    private func resetWrongAttemp() {
        withAnimation(.easeIn(duration: 0.1)) {
            wrongAttemp = false
        }
    }

    // MARK: Flip Animation

    private func performFlipAnimation() {
        let last = appliedGuesses.count - 1
        for index in appliedGuesses[last].isFlipped.indices {
            withAnimation(.easeInOut(duration: 0.75).delay(Double(index) * 0.1)) {
                appliedGuesses[last].isFlipped[index] = true
            }
        }
    }
}
