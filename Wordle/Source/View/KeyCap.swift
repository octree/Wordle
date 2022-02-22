import SwiftUI

struct KeyCap: View {
    var key: Key
    var status: KeyStatus = .idle

    var body: some View {
        Group {
            switch key {
            case .character(let character):
                Text(String(character))
            case .enter:
                Image(systemName: "return")
            case .delete:
                Image(systemName: "delete.left")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }

    private var backgroundColor: Color {
        switch status {
        case .idle:
            return Color(white: 0.9)
        case .used:
            return Color.Assets.Wordle.correct
        case .unused:
            return Color.Assets.Wordle.unused
        }
    }
}
