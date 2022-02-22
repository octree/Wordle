import SwiftUI

struct GameBoard: View {
    @ObservedObject private var vm: GameBoardViewModel

    init(puzzle: Puzzle) {
        _vm = .init(initialValue: .init(puzzle: puzzle))
    }

    var body: some View {
        VStack {
            VStack {
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
                Text("Lose")
            case .won:
                Text("Won")
            }
        }
    }
}
