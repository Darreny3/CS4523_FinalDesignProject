//
//  Leaderboard.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 12/6/22.
//

import SwiftUI

struct Leaderboard: View {
    @EnvironmentObject var viewModel: SignInViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        
        ScrollView {
            Text("Leaderboard")
                .font(.title)
                .bold()
            
            VStack(alignment: .leading) {
                ForEach(viewModel.records.leaderboard) { user in
                    HStack(alignment: .top) {
                        Text("\(user.rank)")
                        
                        VStack(alignment: .leading) {
                            Text("Username: " + "\(user.user)").bold()
                            Text("Footprint: " + "\(user.footprint)")
                        }
                    }
                    .frame(width: 300, alignment: .leading)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.6667672396, green: 0.7527905703, blue: 1, alpha: 0.2662717301)))
                    .cornerRadius(20)
                }
            }
        }
        .onAppear {
            viewModel.getRecords(token: tok_string)
            
        }
    }
}

struct Leaderboard_Previews : PreviewProvider {
    static var previews: some View {
        Leaderboard()
            .environmentObject(viewModel)
    }
}
