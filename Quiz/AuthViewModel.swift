// Authentication ViewModel
class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    func login(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            self.isAuthenticated = true
            completion(nil)
        }
    }
}
