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
