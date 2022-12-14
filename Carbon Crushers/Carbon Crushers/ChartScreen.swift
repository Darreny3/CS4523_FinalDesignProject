//
//  ChartScreen.swift
//  Carbon Crushers
//
//  Created by Darren Yen on 11/9/22.
//

import SwiftUI
import Charts

//Struct for receiving data which is raw
struct FootprintDataRaw: Identifiable {
    let id = UUID()
    let date: Date
    let footprint: Double
    let category: String
    let activity: String
    
    init(year: Int, month: Int, day: Int, category: String, activity: String, footprint: Double ) {
        self.date = Calendar.current.date(from: .init(year: year, month: month, day: day)) ?? Date()
        self.category = category
        self.activity = activity
        self.footprint = footprint

    }
}

//Modify this for carbon footprint!

//struct BarView: View {
//    var body: some View {
//        Chart {
//            ForEach(londonFootprintDataAct) { item in
//                BarMark(x: .value("activity", item.activity),
//                        y: .value("footprint", item.footprint)
//                )
//            }
//        }
//    }
//}

//make scrollable 

struct ChartPage: View {
    @EnvironmentObject var viewModel: SignInViewModel
    var body: some View {
        ZStack{
            ScrollView {
                    Text("Carbon Footprint Graph")
                        .font(.headline)
                        .fontWeight(.semibold)
                Chart {
                    ForEach(self.viewModel.lineHist) { item in
                        LineMark (
                            x: .value("Day", item.timestamp),
                            y: .value("Footprint", item.emission)
                        )
                    }
                }.frame(width: width)
                    .padding(30)
                        //.frame(width :width)
                    Text("Breakdown By Category")
                    Chart {
                    ForEach(self.viewModel.catHist) { item in
                        BarMark (
                            x: .value("Category", item.category!),
                            y: .value("Footprint", item.emission)
                        )
                    }
                    }.frame(width: width)
                    Text("Breakdown By Activity")
                Chart {
                    ForEach(self.viewModel.barHist) { item in
                        BarMark (
                            x: .value("Activity", item.activity!),
                            y: .value("Footprint", item.emission)
                        )
                    }
                }.frame(width: width)
                    .padding(30)
                    //.frame(width: width)
                    //To be added: number of lightbulbs used from 1-10
            }
        }.onAppear{
            self.viewModel.getLineData(token: tok_string)
            self.viewModel.getBarData(token: tok_string)
            self.viewModel.getCatData(token: tok_string)
        }
    }
}


struct ChartScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChartPage().environmentObject(viewModel)
    }
}
