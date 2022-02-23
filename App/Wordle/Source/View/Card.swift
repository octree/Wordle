//
//  Card.swift
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

struct Card: View {
    var light: Color
    var dark: Color
    var cornerRadius: CGFloat = 16
    var borderWidth: CGFloat = 5

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            shape
                .fill(LinearGradient(colors: [dark, light], startPoint: .topLeading, endPoint: .bottomTrailing))
            shape.stroke(
                LinearGradient(colors: [light, dark], startPoint: .topLeading, endPoint: .bottomTrailing),
                lineWidth: borderWidth
            )
        }
    }
}

extension Card {
    init(color: WordleColorProvider.Type,
         cornerRadius: CGFloat = 16,
         borderWidth: CGFloat = 5)
    {
        self.light = color.light
        self.dark = color.dark
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
}
