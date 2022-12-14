//
//  ViewControl.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/29/22.
//

import SwiftUI

let screenRect = UIScreen.main.bounds
let width = screenRect.size.width
let height = screenRect.size.height

//This will essentially dictate view control throughout the application
struct ViewControl: View {

    var body: some View {
        ZStack{
            NavigationView {
                ZStack{
                    Rectangle()
                        .frame(width: width, height: 150)
                        .offset(y: 325)
                        .foregroundColor(Color.green)
                    HStack{
                        NavigationLink(destination: ChartPage()) {
                            Image(systemName: "chart.bar.doc.horizontal")
                                .accentColor(Color.white)
                                .scaleEffect(2)
                        }.offset(x: -width/5)
                        
                        NavigationLink(destination: ActivityScreen()) {
                            Image(systemName:
                            "car")
                            .scaleEffect(2)
                            .accentColor(Color.white)
                        }.offset(x: -width/10)
                        NavigationLink(destination: Leaderboard()) {
                            Image(systemName: "person.3.sequence")
                                .scaleEffect(2)
                                .accentColor(Color.white)
                        }.offset(x: width/20)
                        NavigationLink(destination: UserPage()) {
                            Image(systemName: "person.circle")
                                .scaleEffect(2)
                                .accentColor(Color.white)
                        }.offset(x: width/5)
                    }
                    .offset(y: 17*height/40)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

struct ViewControl_Previews: PreviewProvider {
    static var previews: some View {
        ViewControl()
    }
}
