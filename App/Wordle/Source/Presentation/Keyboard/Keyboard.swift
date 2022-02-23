//
//  Keyboard.swift
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

struct Keyboard: View {
    var guessStatus: GuessStatus
    var onTap: (Key) -> Void

    var body: some View {
        GeometryReader { proxy in
            let keyWidth = proxy.size.width / 10
            VStack(spacing: KeyboardConstants.keySpacing) {
                HStack(spacing: KeyboardConstants.keySpacing) {
                    ForEach(Key.groupedCharacterKeys[0], id: \.self) { key in
                        KeyCap(key: key, status: guessStatus.status(forKey: key))
                            .onTapGesture { onTap(key) }
                    }
                }
                HStack(spacing: KeyboardConstants.keySpacing) {
                    ForEach(Key.groupedCharacterKeys[1], id: \.self) { key in
                        KeyCap(key: key, status: guessStatus.status(forKey: key))
                            .onTapGesture { onTap(key) }
                    }
                }
                .padding(.horizontal, keyWidth / 2)
                HStack(spacing: KeyboardConstants.keySpacing) {
                    KeyCap(key: .enter).frame(width: 3 / 2 * keyWidth)
                        .onTapGesture { onTap(.enter) }
                    ForEach(Key.groupedCharacterKeys[2], id: \.self) { key in
                        KeyCap(key: key, status: guessStatus.status(forKey: key))
                            .onTapGesture { onTap(key) }
                    }
                    KeyCap(key: .delete).frame(width: 3 / 2 * keyWidth)
                        .onTapGesture { onTap(.delete) }
                }
            }
        }
        .frame(height: KeyboardConstants.keyboardHeight)
    }
}

private enum KeyboardConstants {
    static let keyHeight: CGFloat = 60
    static let keySpacing: CGFloat = 8
    static var keyboardHeight: CGFloat {
        keyHeight * 3 + keySpacing * 2
    }
}
