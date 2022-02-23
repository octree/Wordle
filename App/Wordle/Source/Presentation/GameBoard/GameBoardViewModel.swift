//
//  GameBoardViewModel.swift
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

public enum GameConstants {
    public static let maxAttempCount = 10
}

class GameBoardViewModel: ObservableObject {
    private(set) var puzzle: Puzzle
    let allPuzzleWords: Set<String>
    @Published var state: GameState = .playing
    @Published private(set) var appliedGuesses: [Guess] = []
    @Published private(set) var currentGuess: Guess
    @Published private(set) var wrongAttemp: Bool = false
    @Published private(set) var keyStatus: [Key: KeyStatus]
    var proxy: ScrollViewProxy?

    var allGuesses: [Guess] {
        state == .playing ? appliedGuesses + [currentGuess] : appliedGuesses
    }

    init(allPuzzleWords: Set<String>) {
        let puzzle: Puzzle
        let guesses: [Guess]
        if let game = PersistedGame.read() {
            state = game.state
            puzzle = game.puzzle
            guesses = game.guesses
        } else {
            puzzle = .init(word: allPuzzleWords.randomElement()!)
            guesses = []
        }
        self.puzzle = puzzle
        self.allPuzzleWords = allPuzzleWords
        appliedGuesses = guesses
        keyStatus = puzzle.keyStatus(from: guesses)
        currentGuess = puzzle.createEmptyGuess(index: guesses.count)
        saveToDisk()
    }

    // MARK: - Public Method

    func apply() {
        guard currentGuess.guessLetters.count == puzzle.word.count,
              allPuzzleWords.contains(currentGuess.word)
        else {
            performWrongAttempAnimation()
            return
        }
        defer {
            saveToDisk()
        }
        appliedGuesses.append(currentGuess)
        puzzle.mergeKeyStatus(from: currentGuess, to: &keyStatus)
        if currentGuess.word == puzzle.word {
            state = .won
        } else if appliedGuesses.count == GameConstants.maxAttempCount {
            state = .lose
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
        scrollToBottom()
    }

    func setProxy(_ proxy: ScrollViewProxy) {
        self.proxy = proxy
    }

    func playAgain() {
        puzzle = .init(word: allPuzzleWords.randomElement()!)
        state = .playing
        appliedGuesses = []
        currentGuess = puzzle.createEmptyGuess(index: 0)
        keyStatus = [:]
    }

    // MARK: - Private Methods

    private func scrollToBottom() {
        let id = state == .playing ? currentGuess.id : appliedGuesses.last!.id
        proxy?.scrollTo(id, anchor: .bottom)
    }

    private func insert(character: Character) {
        currentGuess.insert(character: character)
    }

    private func deleteBackward() {
        currentGuess.deleteBackward()
    }

    // MARK: Wrong Attemp Animation

    private func performWrongAttempAnimation() {
        withAnimation(.easeIn(duration: 0.08).repeatCount(5, autoreverses: true)) {
            wrongAttemp = true
        }
        Task {
            try await Task.sleep(nanoseconds: 400_000_000)
            await resetWrongAttemp()
        }
    }

    @MainActor
    private func resetWrongAttemp() {
        withAnimation(.easeIn(duration: 0.08)) {
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

    private func saveToDisk() {
        Task {
            PersistedGame(state: state, puzzle: self.puzzle, guesses: self.appliedGuesses)
                .save()
        }
    }
}
