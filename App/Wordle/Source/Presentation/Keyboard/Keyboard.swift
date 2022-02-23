//
//  Keyboard.swift
//  Wordle
//
//  Created by Octree on 2022/2/22.
//

import SwiftUI

public enum Key: Hashable {
    case character(Character)
    case enter
    case delete
}

extension Key: ExpressibleByStringLiteral {
    public init(stringLiteral value: StringLiteralType) {
        self = .character(value.first!)
    }
}

struct KeyLine {
    var keys: [Key]

    static let lines: [KeyLine] = {
        [
            .init(keys: ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]),
            .init(keys: ["A", "S", "D", "F", "G", "H", "J", "K", "L"]),
            .init(keys: ["Z", "X", "C", "V", "B", "N", "M"]),
        ]
    }()
}

struct Keyboard: View {
    var guessStatus: GuessStatus
    var onTap: (Key) -> Void

    var body: some View {
        GeometryReader { proxy in
            let keyWidth = proxy.size.width / 10
            VStack(spacing: KeyboardConstants.keySpacing) {
                HStack(spacing: KeyboardConstants.keySpacing) {
                    ForEach(KeyLine.lines[0].keys, id: \.self) { key in
                        KeyCap(key: key, status: guessStatus.status(forKey: key))
                            .onTapGesture { onTap(key) }
                    }
                }
                HStack(spacing: KeyboardConstants.keySpacing) {
                    ForEach(KeyLine.lines[1].keys, id: \.self) { key in
                        KeyCap(key: key, status: guessStatus.status(forKey: key))
                            .onTapGesture { onTap(key) }
                    }
                }
                .padding(.horizontal, keyWidth / 2)
                HStack(spacing: KeyboardConstants.keySpacing) {
                    KeyCap(key: .enter).frame(width: 3 / 2 * keyWidth)
                        .onTapGesture { onTap(.enter) }
                    ForEach(KeyLine.lines[2].keys, id: \.self) { key in
                        KeyCap(key: key, status: guessStatus.status(forKey: key))
                            .onTapGesture { onTap(key) }
                    }
                    KeyCap(key: .delete).frame(width: 3 / 2 * keyWidth)
                        .onTapGesture { onTap(.delete) }
                }
            }
        }
        .frame(height: KeyboardConstants.keyboardHeight)
    }
}

private enum KeyboardConstants {
    static let keyHeight: CGFloat = 60
    static let keySpacing: CGFloat = 8
    static var keyboardHeight: CGFloat {
        keyHeight * 3 + keySpacing * 2
    }
}
