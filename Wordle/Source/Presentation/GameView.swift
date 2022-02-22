import SwiftUI

struct GameView: View {
    @StateObject private var vm: GameViewModel = .init()
    @State private var showingHelper: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().fill(Color.Assets.Background.primary)
                    .ignoresSafeArea()
                if let puzzle = vm.currentPuzzle {
                    GameBoard(puzzle: puzzle, guesses: vm.guesses, allWorld: vm.wordSet) { vm.loadRandomPuzzle() }
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
