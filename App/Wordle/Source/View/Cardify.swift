//
//  Cardify.swift
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

struct Cardify: Animatable, ViewModifier {
    @Environment(\.difficulty) var difficulty: Difficulty
    var rotationInDegrees: Double
    var guessResult: LetterGuessResult
    var occurrences: Int
    var animatableData: Double {
        get { rotationInDegrees }
        set { rotationInDegrees = newValue }
    }

    init(isFlipped: Bool, guessResult: LetterGuessResult, occurrences: Int) {
        self.rotationInDegrees = isFlipped ? 0 : 180
        self.guessResult = guessResult
        self.occurrences = occurrences
    }

    func body(content: Content) -> some View {
        ZStack {
            if rotationInDegrees < 90 {
                let provider = guessResult.colorProvider
                Card(color: provider, borderWidth: 4)
                Group {
                    content
                    if difficulty == .easy, occurrences > 0 {
                        Text("\(occurrences)")
                            .font(.caption)
                            .padding(6)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    }
                }
                .foregroundColor(provider.extra)
            } else {
                let provider = Color.Assets.Guess.Unused.self
                Card(color: provider, borderWidth: 4)
                content.foregroundColor(provider.extra)
                    .rotation3DEffect(Angle(degrees: 180), axis: (0, 1, 0))
            }
        }
        .rotation3DEffect(Angle(degrees: rotationInDegrees), axis: (0, 1, 0))
    }
}

extension View {
    func cardify(isFlipped: Bool, guessResult: LetterGuessResult, occurrences: Int) -> some View {
        modifier(Cardify(isFlipped: isFlipped, guessResult: guessResult, occurrences: occurrences))
    }
}

extension LetterGuessResult {
    var colorProvider: WordleColorProvider.Type {
        typealias G = Color.Assets.Guess
        switch self {
        case .correct:
            return G.Correct.self
        case .misplaced:
            return G.Misplaced.self
        case .wrong:
            return G.Wrong.self
        }
    }
}
