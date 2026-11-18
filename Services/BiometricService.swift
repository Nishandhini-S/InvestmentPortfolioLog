
import Foundation
import LocalAuthentication

final class BiometricService {

    func authenticate(
        completion: @escaping (Bool, String?) -> Void
    ) {
        let context = LAContext()
        var error: NSError?

        guard context.canEvaluatePolicy(
            .deviceOwnerAuthentication,
            error: &error
        ) else {
            completion(
                false,
                error?.localizedDescription ?? "Authentication unavailable."
            )
            return
        }

        context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: "Unlock your investment portfolio"
        ) { success, authenticationError in

            DispatchQueue.main.async {
                if success {
                    completion(true, nil)
                } else {
                    completion(
                        false,
                        authenticationError?.localizedDescription
                            ?? "Authentication failed."
                    )
                }
            }
        }
    }
}

