import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var rotationInDegrees: Double
    var guessResult: LetterGuessResult
    var animatableData: Double {
        get { rotationInDegrees }
        set { rotationInDegrees = newValue }
    }

    init(isFlipped: Bool, guessResult: LetterGuessResult) {
        self.rotationInDegrees = isFlipped ? 0 : 180
        self.guessResult = guessResult
    }

    func body(content: Content) -> some View {
        ZStack {
            if rotationInDegrees < 90 {
                let provider = guessResult.colorProvider
                Card(color: provider, borderWidth: 4)
                content.foregroundColor(provider.extra)
            } else {
                let provider = Color.Assets.Guess.Unused.self
                Card(color: provider, borderWidth: 4)
                content.foregroundColor(provider.extra)
                    .rotation3DEffect(Angle(degrees: 180), axis: (0, 1, 0))
            }
        }
        .rotation3DEffect(Angle(degrees: rotationInDegrees), axis: (0, 1, 0))
    }
}

extension View {
    func cardify(isFlipped: Bool, guessResult: LetterGuessResult) -> some View {
        modifier(Cardify(isFlipped: isFlipped, guessResult: guessResult))
    }
}

extension LetterGuessResult {
    var colorProvider: WordleColorProvider.Type {
        typealias G = Color.Assets.Guess
        switch self {
        case .correct:
            return G.Correct.self
        case .misplaced:
            return G.Misplaced.self
        case .wrong:
            return G.Wrong.self
        }
    }
}
