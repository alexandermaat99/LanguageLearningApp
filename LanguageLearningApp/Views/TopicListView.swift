//
//  ContentView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

struct TopicListView: View {
    @EnvironmentObject var viewModel: TopicViewModel // Use @EnvironmentObject to access the shared instance

    var body: some View {
        NavigationStack {
            List(viewModel.topics) { topic in
                NavigationLink(destination: LessonView(topic: topic)) {
                    HStack {
                        Text(topic.name)
                            .font(.headline)
                        if topic.isFlashcardsCompleted && topic.isQuizCompleted {
                            Text("✓").foregroundColor(.green) // Show check if both are complete
                        }
                    }
                }
            }
            .navigationTitle("Language Topics")
        }
    }
}

struct TopicListView_Previews: PreviewProvider {
    static var previews: some View {
        TopicListView()
            .environmentObject(TopicViewModel()) // Inject for preview
    }
}
#Preview {
    TopicListView()
}