//
//  BreachBypassApp.swift
//  BreachBypass
//
//  Created by Honma Masaru on 2021/06/02.
//

import SwiftUI

@main
struct BreachBypassApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ImageConvert())
        }
    }
}
