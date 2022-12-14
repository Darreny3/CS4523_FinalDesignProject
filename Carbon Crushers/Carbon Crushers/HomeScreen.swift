//
//  HomeScreen.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/7/22.
//

import SwiftUI

struct homeImage: View {
    var body: some View {
        Image("home")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 75, height: 75)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct logImage: View {
    var body: some View {
            Image("logact")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .padding(.bottom, 75)
        }
        
}


struct HomeScreen: View {
    @State var isHome = false
    var body: some View {
        Text("Hello World")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
