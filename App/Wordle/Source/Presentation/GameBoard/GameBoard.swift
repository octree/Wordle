//
//  GameBoard.swift
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

import SwiftUI

struct GameBoard: View {
    @ObservedObject private var vm: GameBoardViewModel

    init(allPuzzleWords: Set<String>) {
        _vm = .init(initialValue: .init(allPuzzleWords: allPuzzleWords))
    }

    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ScrollViewReader { proxy in
                    let _ = vm.setProxy(proxy)
                    VStack(spacing: 16) {
                        ForEach(vm.allGuesses) { guess in
                            GuessView(puzzle: vm.puzzle, guess: guess)
                                .offset(x: vm.currentGuess.id == guess.id && vm.wrongAttemp ? -30 : 0)
                        }
                    }
                    .padding(.vertical)
                }
            }

            Spacer()
            switch vm.state {
            case .playing:
                Keyboard(keyStatus: vm.keyStatus) { vm.onTap(key: $0) }.padding()
            case .lose:
                VStack {
                    Text("You Lose! \(vm.puzzle.word)")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.red)
                    playAgainView
                }
                .padding()
            case .won:
                VStack {
                    Text("You Won!")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.green)
                    playAgainView
                }
                .padding()
            }
        }
        .environment(\.puzzle, vm.puzzle)
        .environment(\.difficulty, vm.difficulty)
    }

    private var playAgainView: some View {
        Button {
            vm.playAgain()
        } label: {
            Text("Play Again")
        }
        .buttonStyle(.bordered)
    }
}

private enum DifficultyKey: EnvironmentKey {
    static var defaultValue: Difficulty { .easy }
}

private enum PuzzleKey: EnvironmentKey {
    static var defaultValue: Puzzle { .init(word: "") }
}

extension EnvironmentValues {
    var difficulty: Difficulty {
        get { self[DifficultyKey.self] }
        set { self[DifficultyKey.self] = newValue }
    }

    var puzzle: Puzzle {
        get { self[PuzzleKey.self] }
        set { self[PuzzleKey.self] = newValue }
    }
}
