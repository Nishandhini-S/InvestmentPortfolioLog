
import Foundation

struct AuthenticationService {

    func login(username: String, password: String) -> Bool {

        return username == "nisha" && password == "1234"
    }
}

