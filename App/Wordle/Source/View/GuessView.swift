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
                Text(String(guess[index]))
                    .fontWeight(.black)
                    .cardify(isFlipped: guess.isFlipped[index],
                             guessResult: puzzle.guess(guess[index], at: index))
                    .frame(width: 56, height: 56, alignment: .center)
            }
        }
        .padding(.horizontal)
        .font(.title)
    }
}
