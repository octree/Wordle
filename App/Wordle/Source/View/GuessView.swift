//
//  GuessView.swift
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

public struct GuessView: View {
    public var puzzle: Puzzle
    public var guess: Guess

    public var body: some View {
        HStack {
            ForEach(0 ..< puzzle.word.count, id: \.self) { index in
                if index != 0 {
                    Spacer()
                }
                let result = puzzle.guess(guess[index], at: index)
                Text(String(guess[index]))
                    .fontWeight(.black)
                    .cardify(isFlipped: guess.isFlipped[index],
                             guessResult: result,
                             occurrences: puzzle.count(guess[index]))
                    .frame(width: 56, height: 56, alignment: .center)
            }
        }
        .padding(.horizontal)
        .font(.title)
    }
}

extension Puzzle {
    func count(_ character: Character) -> Int {
        word.filter { $0 == character }.count
    }
}
