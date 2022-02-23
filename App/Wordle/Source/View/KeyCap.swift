//
//  Guess.swift
//  KeyCap
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

struct KeyCap: View {
    var key: Key
    var status: KeyStatus = .unused

    var body: some View {
        ZStack {
            Card(color: colorProvider, cornerRadius: 10, borderWidth: 2)
            switch key {
            case .character(let character):
                Text(String(character))
            case .enter:
                Image(systemName: "return")
            case .delete:
                Image(systemName: "delete.left")
            }
        }
        .foregroundColor(colorProvider.extra)
    }

    private var colorProvider: WordleColorProvider.Type {
        typealias G = Color.Assets.Guess
        switch status {
        case .wrong:
            return G.Wrong.self
        case .used:
            return G.Correct.self
        case .unused:
            return G.Unused.self
        }
    }
}
