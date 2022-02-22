import SwiftUI

struct GameView: View {
    var body: some View {
        NavigationView {
            VStack {}
                .navigationViewStyle(.stack)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {} label: {
                            Image(systemName: "questionmark.circle")
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
