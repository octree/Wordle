import SwiftUI

struct GameBoard: View {
    @ObservedObject private var vm: GameBoardViewModel
    var playAgain: () -> ()

    init(puzzle: Puzzle, playAgain: @escaping () -> ()) {
        _vm = .init(initialValue: .init(puzzle: puzzle))
        self.playAgain = playAgain
    }

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                ForEach(vm.allGuesses) { guess in
                    GuessView(puzzle: vm.puzzle, guess: guess)
                        .offset(x: vm.wrongAttemp ? -30 : 0)
                }
            }
            .padding(.top)
            .padding(.horizontal)

            Spacer()
            switch vm.status {
            case .playing:
                Keyboard(guessStatus: vm.guessStatus) { vm.onTap(key: $0) }.padding()
            case .lose:
                VStack {
                    Text("You Lose!")
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
