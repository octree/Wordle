//
//  GameView.swift
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

struct GameView: View {
    @StateObject private var vm: GameViewModel = .init()
    @State private var showingHelper: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().fill(Color.Assets.Background.primary)
                    .ignoresSafeArea()
                if !vm.allPuzzleWords.isEmpty {
                    GameBoard(allPuzzleWords: vm.allPuzzleWords)
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.showingHelper.toggle()
                    } label: {
                        Image(systemName: "questionmark.circle")
                    }
                    .tint(.Assets.Text.secondary)
                    .sheet(isPresented: $showingHelper) {
                        HelpView(isPresented: $showingHelper)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("Wordle").font(.largeTitle).fontWeight(.heavy)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button {} label: {
                            Image(systemName: "chart.bar")
                        }

                        Button {} label: {
                            Image(systemName: "gearshape")
                        }
                    }
                    .tint(.Assets.Text.secondary)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
