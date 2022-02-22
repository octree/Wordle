import SwiftUI

protocol WordleColorProvider {
    static var light: Color { get }
    static var dark: Color { get }
    static var extra: Color { get }
}

extension Color.Assets.Guess.Unused: WordleColorProvider {}
extension Color.Assets.Guess.Wrong: WordleColorProvider {}
extension Color.Assets.Guess.Correct: WordleColorProvider {}
extension Color.Assets.Guess.Misplaced: WordleColorProvider {}
