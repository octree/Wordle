import Foundation

public enum PuzzleLoader {
    public static func loadWords() async throws -> [String] {
        var words = [String]()
        let url = Bundle.main.url(forResource: "wordle", withExtension: "txt")!
        for try await line in url.lines {
            words.append(line)
        }
        return words
    }
}
