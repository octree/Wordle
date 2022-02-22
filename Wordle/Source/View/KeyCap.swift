import SwiftUI

struct KeyCap: View {
    var key: Key
    var status: KeyStatus = .unused

    var body: some View {
        ZStack {
            Card(color: colorProvider, cornerRadius: 10, borderWidth: 2)
            switch key {
            case .character(let character):
                Text(String(character))
            case .enter:
                Image(systemName: "return")
            case .delete:
                Image(systemName: "delete.left")
            }
        }
        .foregroundColor(colorProvider.extra)
    }

    private var colorProvider: WordleColorProvider.Type {
        typealias G = Color.Assets.Guess
        switch status {
        case .wrong:
            return G.Wrong.self
        case .used:
            return G.Correct.self
        case .unused:
            return G.Unused.self
        }
    }
}
