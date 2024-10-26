//
//  TopicListView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//
import SwiftUI

struct TopicListView: View {
    @EnvironmentObject var viewModel: TopicViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.topics) { topic in
                    NavigationLink(destination: LessonView(topicID: topic.id)) {
                        HStack {
                            Text(topic.name)
                                .font(.headline)
                            
                            Spacer()
                            
                            // Flashcards Completion Checkbox
                            HStack {
                                Text("Flashcards")
                                Image(systemName: topic.isFlashcardsCompleted ? "checkmark.square" : "square")
                                    .foregroundColor(topic.isFlashcardsCompleted ? .green : .gray)
                            }
                            .padding(.trailing, 10)
                            
                            // Quiz Completion Checkbox
                            HStack {
                                Text("Quiz")
                                Image(systemName: topic.isQuizCompleted ? "checkmark.square" : "square")
                                    .foregroundColor(topic.isQuizCompleted ? .green : .gray)
                            }
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
            .environmentObject(TopicViewModel())
    }
}

#Preview {
    TopicListView()
}
