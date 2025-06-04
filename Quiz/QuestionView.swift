import SwiftUI
import FirebaseFirestore
import FirebaseAuth


// Question View
struct QuestionView: View {
    let question: Question
    @Binding var selectedAnswers: [Int]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(question.options.indices, id: \.self) { index in
                if question.isMultipleChoice {
                    CheckboxView(
                        text: question.options[index],
                        isChecked: selectedAnswers.contains(index),
                        onToggle: {
                            if selectedAnswers.contains(index) {
                                selectedAnswers.removeAll { $0 == index }
                            } else {
                                selectedAnswers.append(index)
                            }
                        }
                    )
                } else {
                    RadioButtonView(
                        text: question.options[index],
                        isSelected: selectedAnswers.contains(index),
                        onSelect: { selectedAnswers = [index] }
                    )
                }
            }
        }
        .padding(.vertical, 5)
    }
}