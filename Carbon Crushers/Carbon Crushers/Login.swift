//
//  ContentView.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/6/22.
//

import SwiftUI
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct UsernameTextField : View {
    @Binding var username: String
    var body: some View{
        return TextField("Username", text: $username)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
}

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var authenticationDidFail: Bool = false
    @State var authenitcationSuccess: Bool = false
    @State var noAccount: Bool = false
    @State var nav:Bool = false
    @EnvironmentObject var viewModel: SignInViewModel

    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    LogoView().scaleEffect(0.5)
                    WelcomeText()
                    UserImage()
                    UsernameTextField(username: $username)
                    PasswordSecureField(password: $password)
                    
                    VStack{
                        if (!viewModel.canSignIn) {
                            Button(action: {
                                self.viewModel.signIn(username: self.username, password: self.password)
                                self.nav = self.viewModel.canSignIn
                                tok_string = self.viewModel.token_string
                                }) {
                                    LoginButtonContent()
                                }
                            }
                        else {
                            NavigationLink(destination: ViewControl(), isActive: $nav) {
                            }
                        }
                        NavigationLink(destination: AcctView()) {
                            Text("Don't Have An Account Yet?")
                        }
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
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(viewModel)
    }
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 20)
    }
}

struct UserImage: View {
    var body: some View {
        Image("userImage")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 75)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct PasswordSecureField: View {
    @Binding var password: String
    var body: some View {
        return SecureField("Password", text: $password)
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
}
