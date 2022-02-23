import SwiftUI

struct Card: View {
    var light: Color
    var dark: Color
    var cornerRadius: CGFloat = 16
    var borderWidth: CGFloat = 5

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            shape
                .fill(LinearGradient(colors: [dark, light], startPoint: .topLeading, endPoint: .bottomTrailing))
            shape.stroke(
                LinearGradient(colors: [light, dark], startPoint: .topLeading, endPoint: .bottomTrailing),
                lineWidth: borderWidth
            )
        }
    }
}

extension Card {
    init(color: WordleColorProvider.Type,
         cornerRadius: CGFloat = 16,
         borderWidth: CGFloat = 5)
    {
        self.light = color.light
        self.dark = color.dark
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
    }
}
