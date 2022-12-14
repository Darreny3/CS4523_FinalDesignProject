//
//  CreateAccount.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/7/22.
//

import SwiftUI


var viewModel = SignInViewModel()
var tok_string: String = ""

struct AcctView: View {
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var creationSuccess = false
    @State var creationFail = false
    @State var nav: Bool = false
    @EnvironmentObject var viewModel: SignInViewModel
    

    var body: some View {
        NavigationView {
            VStack {
                Text("Create Account")
                UsernameView(username: $username)
                EmailView(email: $email)
                PassView(password: $password)
                
                if !viewModel.canSignIn {
                    Button(action: {
                        self.viewModel.signUp(username: self.username, password: self.password, email: self.email)
                        self.nav = self.viewModel.canSignIn
                        tok_string = self.viewModel.token_string
                        print(self.viewModel.token_string)
                    }) {
                        CreateAcctButton()
                    }
                } else {
                    NavigationLink(destination: ViewControl(), isActive: self.$nav) {
                        
                    }.navigationBarBackButtonHidden(true)
                }
            }
            .padding()
            .alert(isPresented: $viewModel.hasError) {
                        Alert(
                            title: Text("Sign In Failed"),
                            message: Text("The email/password combination is invalid."),
                            dismissButton: .default(Text("OK"), action: {
                                print("Ok Click")
                                self.nav = false
                            })
                        )
                    }
        }.navigationBarBackButtonHidden(self.nav)
    }
}

struct Acctview_Previews: PreviewProvider {
    static var previews: some View {
        AcctView().environmentObject(viewModel)
    }
}


struct CreateAcctButton: View {
    var body: some View {
        Text("Create Account")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UsernameView: View {
    @Binding var username: String
    var body: some View {
       return TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
}

struct EmailView: View {
    @Binding var email: String
    var body: some View {
        return TextField("example: bob123@gmail.com", text: $email)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
}

struct PassView: View {
    @Binding var password: String
    var body: some View {
        return TextField("Password! Be Creative!", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
}
//Check if the email is valid
//Taken from stackoverflow:


func makeData (username: String, password: String, email: String) -> [String: Any] {
    return [
        "username": username,
        "password": password,
        "email": email
    ]
}
