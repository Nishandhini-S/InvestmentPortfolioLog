
import SwiftUI

struct AuthenticationView: View {

    @StateObject private var viewModel: AuthenticationViewModel

    init(appState: AppState) {
        _viewModel = StateObject(
            wrappedValue: AuthenticationViewModel(appState: appState)
        )
    }

    var body: some View {

        VStack(spacing: 25) {

            Spacer()

            Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                .font(.system(size: 75))
                .foregroundStyle(.green)

            Text("Investment Portfolio Log")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text("Securely track your investments")
                .foregroundStyle(.secondary)

            VStack(spacing: 15) {

                TextField("Username", text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                Button("Login") {
                    viewModel.login()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .frame(maxWidth: .infinity)

                Button {
                    viewModel.loginWithBiometrics()
                } label: {
                    Label("Login with Face ID", systemImage: "faceid")
                }
                .buttonStyle(.bordered)
                .frame(maxWidth: .infinity)
            }

            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }

            Spacer()
        }
        .padding(25)
    }
}

