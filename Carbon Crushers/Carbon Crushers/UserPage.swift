//
//  UserPage.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/29/22.
//

import SwiftUI

//username from get request
//email from get request
//rank from get reuqest

let vshift = height/7.5
let space = height/45

struct UserPage: View {
    @EnvironmentObject var viewModel: SignInViewModel
    var body: some View {
        ZStack{
            VStack{
                UserImage()
                    .scaleEffect(2)
                    .offset(y: -height/20)
                Text("Username: " + self.viewModel.username)
                    .font(.system(size: 25))
                    .font(.headline)
                    .bold()
                    .offset(y: -vshift)
                Text("Sharing: " + String(self.viewModel.sharing))
                    .font(.system(size: 25))
                    .font(.headline)
                    .bold()
                    .offset(y: -vshift+space)
                Text("Rank: " + String(self.viewModel.rank))
                    .font(.system(size: 25))
                    .font(.headline)
                    .bold()
                    .offset(y: -vshift+2*space)
                Text("Total Footprint: " + String(self.viewModel.footprint) + " Kg")
                    .font(.system(size: 25))
                    .font(.headline)
                    .bold()
                    .offset(y: -vshift+3*space)
            }
        }.onAppear{
            self.viewModel.getUserData(token: tok_string)
        }
    }
}

struct LogoutButtonContent: View {
    var body: some View {
        Text("LOGOUT")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        UserPage().environmentObject(viewModel)
    }
}
