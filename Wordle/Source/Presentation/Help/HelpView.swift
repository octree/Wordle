import SwiftUI

struct HelpView: View {
    @Binding var isPresented: Bool
    let puzzle = Puzzle(word: "REACH")
    var guess: Guess {
        var guess = puzzle.createEmptyGuess(index: 0)
        guess.guessLetters = "RIVER".map { $0 }
        guess.isFlipped = guess.guessLetters.map { _ in true }
        return guess
    }

    var body: some View {
        ZStack {
            Rectangle().fill(Color.Assets.Background.primary)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("HOW TO PLAY")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.Assets.Text.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {
                                isPresented.toggle()
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.Assets.Text.territory)
                            })
                        }
                    )
                    .padding(.top, 16)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Guess the **WORDLE** in ten tries.")
                        Text("Each guess must be a valid five-letter word. Hit the enter button to submit.")
                        Text("After each guess, the color of the tiles will change to show how close your guess was to the word.")
                    }
                    .font(.body)
                    .foregroundColor(.Assets.Text.secondary)
                    .padding(.top, 8)

                    Text("Example")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.Assets.Text.primary)
                        .padding(.top, 16)

                    VStack {
                        GuessView(puzzle: puzzle, guess: guess)
                    }
                    .padding(.horizontal, -16)
                    .padding(.top, 16)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("The letter **R** is in the word and in the correct spot.")
                        Text("The letter **E** and **R** is in the word but in the wrong spot.")
                        Text("The letter **I** and **V** is not in the word in any spot.")
                    }
                    .font(.body)
                    .foregroundColor(.Assets.Text.secondary)
                    .padding(.top, 16)
                }
                .padding()
            }
        }
    }
}
