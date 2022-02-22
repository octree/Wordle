import SwiftUI

extension LetterGuessResult {
    var color: Color {
        switch self {
        case .correct:
            return .Assets.Wordle.correct
        case .misplaced:
            return .Assets.Wordle.misplaced
        case .unused:
            return .Assets.Wordle.unused
        }
    }
}

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
            let shape = RoundedRectangle(cornerRadius: 12, style: .continuous)
            if rotationInDegrees < 90 {
                shape.fill()
                    .foregroundColor(guessResult.color)
                content

            } else {
                shape.fill()
                    .foregroundColor(.white)
                content
                    .rotation3DEffect(Angle(degrees: 180), axis: (0, 1, 0))
                shape.stroke(Color.gray, lineWidth: 2)
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
