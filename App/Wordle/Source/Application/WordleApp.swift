//
//  WordleApp.swift
//  Wordle
//
//  Created by Octree on 2022/2/16.
//

import SwiftUI

@main
struct WordleApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "Background/Primary")
        appearance.shadowImage = UIColor.clear.image()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
