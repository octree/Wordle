import SwiftUI

struct KeyCap: View {
    var body: some View {
        Text("A")
            .foregroundColor(Color("Keyboard/text"))
            .padding()
            .background(Color("Keyboard/background"))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color("Keyboard/border"), lineWidth: 2)
            )
    }
}

struct KeyCap_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            KeyCap()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(white: 0.7))
    }
}
