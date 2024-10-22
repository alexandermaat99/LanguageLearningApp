//
//  ContentView.swift
//  LanguageLearningApp
//
//  Created by Alexander Maat on 10/22/24.
//

import SwiftUI

struct TopicListView: View {
    @StateObject var viewModel = TopicViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.topics) { topic in
                NavigationLink(destination: LessonView(topic: topic)) {
                    Text(topic.name)
                        .font(.headline)
                }
            }
            .navigationTitle("Language Topics")
            .onAppear {
                viewModel.loadTopics()
            }
        }
    }
}

struct TopicListView_Previews: PreviewProvider {
    static var previews: some View {
        TopicListView()
    }
}


#Preview {
    TopicListView()
}
