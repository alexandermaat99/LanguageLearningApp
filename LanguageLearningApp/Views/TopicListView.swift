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
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: geometry.size.width > 500 ? 400 : geometry.size.width - 32, maximum: .infinity))], spacing: 16) {
                        ForEach(viewModel.topics) { topic in
                            NavigationLink(destination: LessonView(topicID: topic.id)) {
                                TopicCard(topic: topic)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Language Topics")
        }
    }
}

struct TopicCard: View {
    let topic: Topic
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Text(topic.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 8) {
                ProgressIndicator(label: "Flashcards", isCompleted: topic.isFlashcardsCompleted)
                ProgressIndicator(label: "Quiz", isCompleted: topic.isQuizCompleted)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ProgressIndicator: View {
    let label: String
    let isCompleted: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isCompleted ? .green : .gray)
        }
    }
}

struct TopicListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TopicListView()
                .environmentObject(TopicViewModel())
                .previewDisplayName("Portrait")
            
            TopicListView()
                .environmentObject(TopicViewModel())
                .previewInterfaceOrientation(.landscapeLeft)
                .previewDisplayName("Landscape")
        }
    }
}
