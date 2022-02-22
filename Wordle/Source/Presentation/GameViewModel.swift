import SwiftUI

@MainActor
public class GameViewModel: ObservableObject {
    private var words: [String] = []
    private(set) var wordSet: Set<String> = []
    @Published public private(set) var currentPuzzle: Puzzle?

    init() {
        Task {
            do {
                self.words = try await PuzzleLoader.loadWords()
                self.wordSet = Set(self.words)
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
