import SwiftUI
import FirebaseFirestore
import FirebaseAuth

// Checkbox View
struct CheckboxView: View {
    let text: String
    let isChecked: Bool
    let onToggle: () -> Void
    
    var body: some View {
        Button(action: onToggle) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                Text(text)
            }
        }
        .foregroundColor(.primary)
    }
}