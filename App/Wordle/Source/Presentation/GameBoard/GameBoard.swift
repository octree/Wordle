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
    var playAgain: () -> ()

    init(puzzle: Puzzle, guesses: [Guess], allWorld: Set<String>, playAgain: @escaping () -> ()) {
        _vm = .init(initialValue: .init(puzzle: puzzle, guesses: guesses, allWorld: allWorld))
        self.playAgain = playAgain
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
            switch vm.status {
            case .playing:
                Keyboard(guessStatus: vm.guessStatus) { vm.onTap(key: $0) }.padding()
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
    }

    private var playAgainView: some View {
        Button {
            playAgain()
        } label: {
            Text("Play Again")
        }
        .buttonStyle(.bordered)
    }
}
