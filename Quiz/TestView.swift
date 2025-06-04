import SwiftUI
import FirebaseFirestore
import FirebaseAuth


// Test View
struct TestView: View {
    @StateObject private var viewModel = TestViewModel()
    @State private var userName = ""
    @State private var showResults = false
    
    var body: some View {
        VStack {
            if viewModel.questions.isEmpty {
                ProgressView("Loading questions...")
            } else if showResults {
                ResultsView(score: viewModel.calculateScore(), percentage: viewModel.calculatePercentage())
            } else {
                List {
                    Section(header: Text("Your Name")) {
                        TextField("Enter your name", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    ForEach(viewModel.questions.indices, id: \.self) { index in
                        QuestionView(
                            question: viewModel.questions[index],
                            selectedAnswers: $viewModel.selectedAnswers[index]
                        )
                    }
                }
                
                Button(action: {
                    if !userName.isEmpty {
                        viewModel.submitResults(userName: userName)
                        showResults = true
                    }
                }) {
                    Text("Submit Test")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(userName.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .disabled(userName.isEmpty)
                }
                .padding()
            }
        }
        .navigationTitle("Take Quiz")
        .onAppear {
            viewModel.fetchQuestions()
        }
    }
}