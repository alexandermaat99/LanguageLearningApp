//
//  LanguageLearningAppApp.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

@main
struct LanguageLearningApp: App {
    var body: some Scene {
        WindowGroup {
            TopicListView()
                .environmentObject(TopicViewModel()) // Inject environment object
        }
    }
}
