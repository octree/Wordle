//
//  Color Assets
//
//  ⚠️ DO NOT EDIT.
//  Code generated by Yep(https://github.com/octree/Yep) on 2022/2/23.
//  Copyright © 2022 Octree. All rights reserved.
//

import SwiftUI

extension Color {
    // MARK: - Assets

    public enum Assets {
        public static var accentColor: Color {
            return Color("AccentColor")
        }

        // MARK: - Background

        public enum Background {
            public static var primary: Color {
                return Color("Background/Primary")
            }
        }

        // MARK: - Guess

        public enum Guess {
            // MARK: - Correct

            public enum Correct {
                public static var dark: Color {
                    return Color("Guess/Correct/dark")
                }

                public static var extra: Color {
                    return Color("Guess/Correct/extra")
                }

                public static var light: Color {
                    return Color("Guess/Correct/light")
                }
            }

            // MARK: - Misplaced

            public enum Misplaced {
                public static var dark: Color {
                    return Color("Guess/Misplaced/dark")
                }

                public static var extra: Color {
                    return Color("Guess/Misplaced/extra")
                }

                public static var light: Color {
                    return Color("Guess/Misplaced/light")
                }
            }

            // MARK: - Unused

            public enum Unused {
                public static var dark: Color {
                    return Color("Guess/Unused/dark")
                }

                public static var extra: Color {
                    return Color("Guess/Unused/extra")
                }

                public static var light: Color {
                    return Color("Guess/Unused/light")
                }
            }

            // MARK: - Wrong

            public enum Wrong {
                public static var dark: Color {
                    return Color("Guess/Wrong/dark")
                }

                public static var extra: Color {
                    return Color("Guess/Wrong/extra")
                }

                public static var light: Color {
                    return Color("Guess/Wrong/light")
                }
            }
        }

        // MARK: - Text

        public enum Text {
            public static var primary: Color {
                return Color("Text/Primary")
            }

            public static var secondary: Color {
                return Color("Text/Secondary")
            }

            public static var territory: Color {
                return Color("Text/Territory")
            }
        }
    }
}
