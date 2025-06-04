import SwiftUI
import FirebaseFirestore
import FirebaseAuth

// Radio Button View
struct RadioButtonView: View {
    let text: String
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack {
                Image(systemName: isSelected ? "circle.fill" : "circle")
                Text(text)
            }
        }
        .foregroundColor(.primary)
    }
}