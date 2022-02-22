import SwiftUI

@MainActor
public class GameViewModel: ObservableObject {
    private var words: [String] = []
    @Published public private(set) var currentPuzzle: Puzzle?

    init() {
        Task {
            do {
                self.words = try await PuzzleLoader.loadWords()
                self.loadRandomPuzzle()
            } catch {
                print(error)
            }
        }
    }

    func loadRandomPuzzle() {
        currentPuzzle = words.randomElement().map { Puzzle(word: $0) }
    }
}
